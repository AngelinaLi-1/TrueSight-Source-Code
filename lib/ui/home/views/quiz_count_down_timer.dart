import 'package:realorfake/ui/widgets/widgets.dart';

class QuizCountdownTimerView extends StatefulWidget {
  final String startTime;
  final String startDate;
  final VoidCallback onTimerComplete;
  final Function() onClickPlay;
  const QuizCountdownTimerView({
    super.key,
    required this.startTime,
    required this.startDate,
    required this.onTimerComplete,
    required this.onClickPlay,
  });

  @override
  State<QuizCountdownTimerView> createState() => _QuizCountdownTimerViewState();
}

class _QuizCountdownTimerViewState extends State<QuizCountdownTimerView> {
  late DateTime quizStartTime;
  Duration remainingTime = const Duration();
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    quizStartTime = _parseQuizStartTime();
    _startTimer();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  DateTime _parseQuizStartTime() {
    DateTime date = DateTime.parse(widget.startDate);
    // Split the start time string to extract hours and minutes
    List<String> timeParts = widget.startTime.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    return DateTime(date.year, date.month, date.day, hours, minutes);
  }

  void _startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = quizStartTime.difference(DateTime.now());
        if (remainingTime.isNegative) {
          countdownTimer?.cancel();
          widget.onTimerComplete(); // Trigger the callback
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: remainingTime.isNegative
          ? GestureDetector(
              onTap: widget.onClickPlay,
              child: const Padding(
                padding: EdgeInsets.only(right: 10),
                child:
                    Icon(Icons.play_circle_fill, size: 45, color: Colors.green),
              ),
            )
          : Row(
              children: [
                Container(
                  height: 20,
                  width: 25,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: AppColors.instance.blue.withOpacity(0.3),
                  ),
                  child: Center(
                    child: CustomSubHeaderWidget(
                      _getDays(remainingTime),
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.instance.white,
                    ),
                  ),
                ),
                const Text(":"),
                Container(
                  height: 20,
                  width: 25,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: AppColors.instance.blue.withOpacity(0.3),
                  ),
                  child: Center(
                    child: CustomSubHeaderWidget(
                      _getHours(remainingTime),
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.instance.white,
                    ),
                  ),
                ),
                const Text(":"),
                Container(
                  height: 20,
                  width: 25,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: AppColors.instance.blue.withOpacity(0.3),
                  ),
                  child: Center(
                    child: CustomSubHeaderWidget(
                      _getMinutes(remainingTime),
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.instance.white,
                    ),
                  ),
                ),
                const Text(":"),
                Container(
                  height: 20,
                  width: 25,
                  margin: const EdgeInsets.only(
                      top: 5, left: 5, bottom: 5, right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: AppColors.instance.blue.withOpacity(0.3),
                  ),
                  child: Center(
                    child: CustomSubHeaderWidget(
                      _getSeconds(remainingTime),
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.instance.white,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  String _getDays(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String days = twoDigits(duration.inDays);
    return days;
  }

  String _getHours(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours.remainder(24));
    return hours;
  }

  String _getMinutes(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    return minutes;
  }

  String _getSeconds(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return seconds;
  }
}

public class DataGeneratorScheduler {
    public void Schedule() {
        // Can't run jobs more than every hour but we can queue up 4 and ofset them by 15 minutes
        System.schedule('dataGen0min', '0 0 * * * ?', new DataGenerator());
        System.schedule('dataGen15min', '0 15 * * * ?', new DataGenerator());
        System.schedule('dataGen30min', '0 30 * * * ?', new DataGenerator());
        System.schedule('dataGen45min', '0 45 * * * ?', new DataGenerator());
    }
}
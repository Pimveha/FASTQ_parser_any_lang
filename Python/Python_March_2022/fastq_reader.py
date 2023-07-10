from json import dumps


class Fastq_r():
    def __init__(self, fastq):
        self.fastq = fastq
        self.fastq_dict = {}

    def get_raw_fastq(self):
        return self.fastq

    def get_seq(self):
        pros_fastq = self.fastq.split("\n")[:-1]
        return pros_fastq[1::4]

    def get_GC_ratio(self):
        seq_only_cont_string = self.get_seq()
        cg_only_string = seq_only_cont_string.replace("T", "").replace("A", "")
        print(f"{len(cg_only_string)} out of the {len(seq_only_cont_string)} bases contain C/G\nThis is around {len(cg_only_string)/len(seq_only_cont_string):.3%}")
        return len(cg_only_string)/len(seq_only_cont_string)

    def get_read_quality(self):
        pros_fastq = self.fastq.split("\n")[:-1]
        qlt_seq_list = pros_fastq[3::4]
        qlt_score_list = []
        for qual in qlt_seq_list:
            # temp_seq_qlt_list = []
            seq_qual = [ord(char) - 33 for char in qual]
            # temp_seq_qlt_list = [
            #     ord(qlt_seq_list[i][j])-33 for j in range(len(qlt_seq_list[i]))]
            # print(temp_seq_qlt_list)
            qlt_score_list.append(seq_qual)
            # qlt_seq_list[i]
        return qlt_score_list

    def get_size_graph(self):
        import matplotlib.pyplot as plt
        pros_fastq = self.fastq.split("\n")[:-1]
        seq_only = pros_fastq[1::4]
        length_list = []

        for i in range(len(seq_only)):
            length_list.append(len(seq_only[i]))

            # these values should change depending on the sample.
        plt.hist(length_list, bins=100, range=(0, 2000))
        plt.ylabel('Frequency')
        plt.show()

    def get_mean_sequence_length(self):
        pros_fastq = self.fastq.split("\n")[:-1]
        seq_only = pros_fastq[1::4]
        length_list = []

        for i in range(len(seq_only)):
            length_list.append(len(seq_only[i]))

        avg = sum(length_list)/len(length_list)
        return avg

    def get_all_reads(self):
        pros_fastq = self.fastq.split("\n")[:-1]
        seq_only = pros_fastq[1::4]
        return seq_only

    def get_good_reads(self, score):
        pros_fastq = self.fastq.split("\n")[:-1]
        qlt_seq_list = pros_fastq[3::4]
        seq_list = pros_fastq[1::4]
        qlt_score_list = []
        for i in range(len(qlt_seq_list)):
            temp_seq_qlt_list = []
            temp_seq_qlt_list = [
                ord(qlt_seq_list[i][j])-33 for j in range(len(qlt_seq_list[i]))]
            # print(temp_seq_qlt_list)
            qlt_score_list.append(temp_seq_qlt_list)

        seq_above_threshold_list = []
        for i in range(len(qlt_score_list)):
            if sum(qlt_score_list[i])/len(qlt_score_list[i]) > score:
                seq_above_threshold_list.append(seq_list[i])

        print(f"{len(seq_above_threshold_list)} have a score above {score}\nthis is around {len(seq_above_threshold_list)/len(seq_list):.3%}")
        return seq_above_threshold_list

    def get_avg_qlt_score(self):
        pros_fastq = self.fastq.split("\n")[:-1]
        qlt_seq_list = pros_fastq[3::4]
        tot_qlt_score_list = []
        for i in range(len(qlt_seq_list)):
            temp_seq_qlt_list = [
                ord(qlt_seq_list[i][j])-33 for j in range(len(qlt_seq_list[i]))]
            # print(temp_seq_qlt_list)
            tot_qlt_score_list += (temp_seq_qlt_list)

        # for i in range()
        # 22.270785053678754
        print("\naverage quality of reads")
        return sum(tot_qlt_score_list)/len(tot_qlt_score_list)

    def get_avg_qlt_score_cut_off(self, begin, end):
        pros_fastq = self.fastq.split("\n")[:-1]
        qlt_seq_list = pros_fastq[3::4][begin:-end]
        tot_qlt_score_list = []
        for i in range(len(qlt_seq_list)):
            temp_seq_qlt_list = [
                ord(qlt_seq_list[i][j])-33 for j in range(len(qlt_seq_list[i]))]
            # print(temp_seq_qlt_list)
            tot_qlt_score_list += (temp_seq_qlt_list)

        # for i in range()
        # 22.270785053678754
        print("\naverage quality of reads with cut off")
        return sum(tot_qlt_score_list)/len(tot_qlt_score_list)

    # Bio.SeqIO.QualityIO()

    def gen_name_read_qlt_dict(self):
        pros_fastq = self.fastq.split("\n")[:-1]
        gen_dict = {}
        for i in range(0, len(pros_fastq), 4):
            gen_dict[pros_fastq[i]] = (pros_fastq[i+1], pros_fastq[i+3])
        self.fastq_dict = gen_dict

    def get_name_read_qlt_dict(self):
        return self.fastq_dict

    def get_quality_score_distr_graph(self):
        # from sklearn import preprocessing
        import matplotlib.pyplot as plt
        pros_fastq = self.fastq.split("\n")[:-1]
        qlt_seq_list = pros_fastq[3::4]
        qlt_score_list = []
        long_qlt_score = []

        for i in range(len(qlt_seq_list)):
            temp_seq_qlt_list = []
            temp_seq_qlt_list = [
                ord(qlt_seq_list[i][j])-33 for j in range(len(qlt_seq_list[i]))]
            # print(temp_seq_qlt_list)
            long_qlt_score += temp_seq_qlt_list
            qlt_score_list.append(temp_seq_qlt_list)
        # Ik heb dit al eerder geschreven is het dan handig om het te kunnen gebruiken als het al eerder is aangeroepen?
        # is het handig om het meteen aan te maken als ik de Fastq_r klasse aanroep?

        # normalize lengthe
        # 0-1
        # https://stackoverflow.com/questions/47999159/normalizing-two-histograms-in-the-same-plot
        # noramlize values
        # https://www.educative.io/edpresso/data-normalization-in-python

        # normalize index position of read quality

        # plt.hist(qlt_score_list, bins = 100, range = (0,2000))

        # gen normalized length list
        norm_len_list = []
        for i in range(len(qlt_score_list)):
            temp_len_list = []
            temp_len_list = [j / len(qlt_score_list[i])
                             for j in range(len(qlt_score_list[i]))]
            norm_len_list += temp_len_list

        plt.scatter(norm_len_list, long_qlt_score, s=1)
        plt.show()
        # normalize lengthe

    # def get_total_bases():

    def get_raw_qlt(self):
        pros_fastq = self.fastq.split("\n")[:-1]
        qlt_seq_list = pros_fastq[3::4]
        return qlt_seq_list

    def get_qlt_hist(self):
        import matplotlib.pyplot as plt
        pros_fastq = self.fastq.split("\n")[:-1]
        qlt_seq_list = pros_fastq[3::4]

        tot_qlt_score_list = []
        for i in range(len(qlt_seq_list)):
            temp_seq_qlt_list = [
                ord(qlt_seq_list[i][j])-33 for j in range(len(qlt_seq_list[i]))]
            # print(temp_seq_qlt_list)
            tot_qlt_score_list += (temp_seq_qlt_list)

        plt.hist(tot_qlt_score_list, bins=92)
        plt.show()

    def avg_q_per_read(self):
        avg_q_list = []
        for q in self.fastq.split("\n")[:-1][3::4]:
            avg_q_list.append(sum([ord(i)-33 for i in q])/len(q))
        return avg_q_list


def read_file(name):
    with open(f"{name}.fastq", "r") as f:
        r_f = f.read()
    return r_f


def main():
    fasta_file = read_file("../../example")
    seq = Fastq_r(fasta_file)
    print(seq.get_read_quality())

    print(seq.avg_q_per_read())


if __name__ == '__main__':
    main()

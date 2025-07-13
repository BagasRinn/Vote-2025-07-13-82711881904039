import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";

actor Vote {
  // Daftar opsi voting
  let options = ["Kucing", "Anjing", "Burung"];
  // Penyimpanan hasil voting
  var votes = HashMap.HashMap<Text, Nat>(3, Text.equal, Text.hash);

  // Inisialisasi hasil voting ke 0
  for (opt in options.vals()) {
    votes.put(opt, 0);
  };

  // Fungsi untuk melakukan voting
  public func vote(option: Text): async Text {
    if (votes.contains(option)) {
      let current = votes.get(option);
      switch (current) {
        case (?n) { votes.put(option, n + 1); };
        case null { votes.put(option, 1); };
      };
      return "Vote berhasil untuk " # option;
    } else {
      return "Opsi tidak ditemukan.";
    }
  };

  // Fungsi untuk melihat hasil voting
  public query func getResults(): async [(Text, Nat)] {
    votes.entries();
  };
}

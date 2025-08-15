# TEA
Tiny Encryption Algorithm

The Tiny Encryption Algorithm is block cipher and it is simpler as a few lines of the 
code. It is fast, secure and simple in description and implementation than IDEA even though it uses same 
algebraic mixed group’s technique. As the confidentiality of the data is more important TEA is secure and needs 
minimal storage space. Tea is highly resistant to differential cryptanalysis and achieves complete diffusion. The 
cipher was developed by Wheeler and Needham in 1994.Fig.3 shows the block diagram of TEA. 
The TEA takes 64 bit (block size) data bits using 128 bit keys with 32 rounds. This cipher starts with a 
64 bit data block that is split up into two 32 bit blocks in which the block on the left side is called as L and the 
block on the right side is called as R. These blocks are swapped per Round. 

More details on TEA can be found here : https://www.researchgate.net/publication/313847879_A_Survey_on_Various_Lightweight_Cryptographic_Algorithms_on_FPGA

This repository implements both encryption and decryption of the Tiny Encryption Algorithm (TEA) in two variants: a standard (non-pipelined) version and a pipelined version.
All designs are written in synthesizable Verilog, suitable for ASIC implementation, and have been synthesized using the saed90nm technology node in Cadence Genus.
From: Petr Slansky <slansky@usa.net>
Subject: hw problem with serial loopback?
Date: Sat, 08 May 2004 00:24:07 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <204iegwyH4192S08.1083968647@uwdvg008.cms.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cmsrelay01.mx.net ([165.212.11.110]:36826 "HELO
	cmsrelay01.mx.net") by vger.kernel.org with SMTP id S263828AbUEGWYM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 May 2004 18:24:12 -0400
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello Experts!

I see a interesting modification of data that goes through serial loopback
cable. Cable is simple serial loopback, with RTS/CTS dataflow control. When a
file of size about 512kB is filtered through serial loopback, I can see that
sometimes a sequence of 16bytes is modified (order shift, first and last byte
modified). Modifications are random, in place and frequency. I observe this
only with one notebook (IBM Thinkpad 570, Mobile PII-366MHz). I guess that
this is a bug in hw implementation of uart 16550 as when I run the same test
on older notebook (TP 560, P233MMX) or PC with VIA chipset and AMD Duron600, I
see no modification of data. Details:

I run MDK9.1 with 2.4.21-030mdk kernel. Data stream was generated with
command: "cat /dev/urandom >urandom.bin". 

Test script to test serial loopback:
#!/bin/sh
SPORT=/dev/ttyS0
BAUD=38400

INPUT=input.bin
OUTPUT=urandom.bin

STTYOPS="$BAUD raw cs8 crtscts clocal -parenb -cstopb -echo"
echo Test file: $OUTPUT
cat $SPORT > $INPUT &
stty $STTYOPS < $SPORT
stty -a < $SPORT
cat $OUTPUT > $SPORT
sleep 1
killall cat
#cmp  $OUTPUT $INPUT
cmp -l $OUTPUT $INPUT | less

Here is what I get, just an example, one of many:
 69473 267 274
 69474   0 267
 69475 263   0
 69476 310 263
 69477 156 310
 69478 341 156
 69479 236 341
 69480  53 236
 69481 162  53
 69482 313 162
 69483  24 313
 69484 163  24
 69485 203 163
 69486 125 203
 69487  10 125
 69488  32  10
288481 240 373
288482 245 240
288483 212 245
288484 204 212
288485 240 204
288486 242 240
288487  23 242
288488 356  23
288489 366 356
288490 136 366
288491 257 136
288492 104 257
288493 314 104
288494 153 314
288495 314 153
288496  75 314
304001 263  63
304002 115 263
304003 165 115
304004 233 165
304005 237 233
304006  74 237
304007   0  74
304008 125   0
304009 326 125
304010   4 326
304011 154   4
304012 101 154
304013  13 101
304014  74  13
304015  66  74
304016 250  66
466945  26 125
466946 247  26
466947 357 247
466948 203 357
466949  76 203
466950 244  76
466951  76 244
466952  26  76
466953 301  26
466954 333 301
466955 322 333
466956 251 322
466957  70 251
466958 112  70
466959  46 112
466960 340  46

You can recognize a sequences of 16 bytes that differ, it looks like FIFO
related problem.

Here is a detail of one such sequence:
$ hexdump -b -s 303990 -n 32 urandom.bin 
004a376 251 045 351 106 353 051 057 113 256 164 263 115 165 233 237 074
004a386 000 125 326 004 154 101 013 074 066 250 331 363 260 035 032 220
004a396

$ hexdump -b -s 303990 -n 32 input.bin
004a376 251 045 351 106 353 051 057 113 256 164 063 263 115 165 233 237
004a386 074 000 125 326 004 154 101 013 074 066 331 363 260 035 032 220
004a396

Some information about notebook HW:
$ lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev
03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev
03)
00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear
SoundFusion Audio Accelerator] (rev 01)
00:06.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:06.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)

Is this a known problem? Could be this a Linux driver problem??

Regards,
Petr


---------------------------------
  Petr Slansky, slansky@usa.net
---------------------------------



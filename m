From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v5 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Sun, 12 Jun 2016 18:13:07 +0100
Message-ID: <1465751587.15050.23.camel@nexus-software.ie>
References: <1462547840-14091-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1463065601.17131.319.camel@linux.intel.com>
	 <1463620733.4224.75.camel@nexus-software.ie>
	 <1464111448.31269.67.camel@linux.intel.com>
	 <1464113301.31269.79.camel@linux.intel.com>
	 <1464280589.2351.19.camel@nexus-software.ie>
	 <CAHp75VczbhPEvp6gn-5hPFdSGscNeyZMzPQWeeB1Xza1mHD8dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VczbhPEvp6gn-5hPFdSGscNeyZMzPQWeeB1Xza1mHD8dw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-06-07 at 13:04 +0300, Andy Shevchenko wrote:
> > I'll find some time to look at both a short stream and a long
> stream,
> > based on the branch you've indicated and maybe against the latest
> > stable kernel.
>=20
> Please, do. I'm planning to resend new version soon (this week or
> lately beginning of the next one).

So.

Generally DMA appears to make little-to-no difference here. With small
data sets, 128 bytes in the test case - there appears to be a slight
performance gain at lower BAUD rates, however for small data-sets and
large data sets 32k for the large test case, there appears to be a
performance penalty at higher BAUD rates.

One thing I have noticed is that the following never completes and
can't be reset back to mode=3D0 or mode=3D3 to restore functionality -
definitely worth looking at if you are spinning another patch.

### never completes ####
root@galileo:~# echo 1 > /sys/class/tty/ttyS0/dma_mode
root@galileo:~# stty -F /dev/ttyS0 921600
root@galileo:~# time cat tester.txt > /dev/ttyS0
### never completes ####

Performance data set

root@galileo:~# dmesg > tester.txt
root@galileo:~# ls -las tester.txt=C2=A0
32 -rw-r--r-- 1 root root 32300
Jan=C2=A0=C2=A01=C2=A0=C2=A02001 tester.txt


#### With DMA on @ 926100 32k file ####

root@galileo:~# echo 0 > /sys/class/tty/ttyS0/dma_mode
root@galileo:~# stty -F /dev/ttyS0 921600
root@galileo:~# time cat tester.txt > /dev/ttyS0

real=C2=A0=C2=A0=C2=A0=C2=A00m0.421s
user=C2=A0=C2=A0=C2=A0=C2=A00m0.010s
sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.000s


### With NoDMA on @ 926100 32k file ####

root@galileo:~# echo 3 > /sys/class/tty/ttyS0/dma_mode
root@galileo:~# stty -F /dev/ttyS0 921600
root@galileo:~# time cat tester.txt > /dev/ttyS0

real=C2=A0=C2=A0=C2=A0=C2=A00m0.421s
user=C2=A0=C2=A0=C2=A0=C2=A00m0.020s
sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.000s

#### With DMA on @ 9600 32k file ####
root@galileo:~# echo 0 > /sys/class/tty/ttyS0/dma_mode
root@galileo:~# stty -F /dev/ttyS0 9600=C2=A0=C2=A0
root@galileo:~# time cat tester.txt > /dev/ttyS0

real=C2=A0=C2=A0=C2=A0=C2=A00m34.381s
user=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.010s

#### With NoDMA on @ 9600 32k file #####
root@galileo:~# echo 3 > /sys/class/tty/ttyS0/dma_mode
root@galileo:~# stty -F /dev/ttyS0 9600
root@galileo:~# time cat tester.txt > /dev/ttyS0

real=C2=A0=C2=A0=C2=A0=C2=A00m34.391s
user=C2=A0=C2=A0=C2=A0=C2=A00m0.010s
sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.000s


root@galileo:~# ls -las tester_small.txt=C2=A0
4 -rw-r--r-- 1 root root 128 Jan=C2=A0=C2=A01 00:06 tester_small.txt

### With DMA on @ 921600 128 byte test file ###
root@galileo:~# stty -F /dev/ttyS0 921600
root@galileo:~# echo 0 > /sys/class/tty/ttyS0/dma_mode
root@galileo:~# time cat tester_small.txt > /dev/ttyS0

real=C2=A0=C2=A0=C2=A0=C2=A00m0.031s
user=C2=A0=C2=A0=C2=A0=C2=A00m0.010s
sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.000s

### With NoDMA on @ 921600 128 byte test file ###
root@galileo:~# stty -F /dev/ttyS0 921600
root@galileo:~# echo 3 > /sys/class/tty/ttyS0/dma_mode
root@galileo:~# time cat tester_small.txt > /dev/ttyS0

real=C2=A0=C2=A0=C2=A0=C2=A00m0.013s
user=C2=A0=C2=A0=C2=A0=C2=A00m0.010s
sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.000s

### With DMA on @ 9600 128 byte test file ###
root@galileo:~# stty -F /dev/ttyS0 9600
root@galileo:~# echo 0 > /sys/class/tty/ttyS0/dma_mode
root@galileo:~# time cat tester_small.txt > /dev/ttyS0

real=C2=A0=C2=A0=C2=A0=C2=A00m0.161s
user=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.010s

### With NoDMA on @ 9600 128 byte test file ###
root@galileo:~# stty -F /dev/ttyS0 9600
root@galileo:~# echo 3 > /sys/class/tty/ttyS0/dma_mode
root@galileo:~# time cat tester_small.txt > /dev/ttyS0

real=C2=A0=C2=A0=C2=A0=C2=A00m0.161s
user=C2=A0=C2=A0=C2=A0=C2=A00m0.000s
sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00m0.000s

---
bod

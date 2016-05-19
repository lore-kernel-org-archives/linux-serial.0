From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v5 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Thu, 19 May 2016 02:18:53 +0100
Message-ID: <1463620733.4224.75.camel@nexus-software.ie>
References: <1462547840-14091-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1463065601.17131.319.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463065601.17131.319.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Thu, 2016-05-12 at 18:06 +0300, Andy Shevchenko wrote:
> On Fri, 2016-05-06 at 18:17 +0300, Andy Shevchenko wrote:
> > This is combined series of two things:
> > - split out the Intel LPSS specific driver from 8250_pci into
> > 8250_lpss
> > - enable DMA support on Intel Quark UART
> > 
> > The patch has been tested on few Intel SoCs / platforms. In any
> > case I
> > would
> > like to ask Bryan to do independent test.

Andy.

It looks as though there's a performance drop when enabling the DMA
here (v) stock PIO mode with the 8250 driver.

Test setup Galileo Gen1 transmitter - Galileo Gen2 receiver. TX/RX
cross-wired between the Arduino UART headers respectively (pins 0 & 1
on the "Digital PWM" header), GND pin14 similarly cross-wired.

User-space:
    Receiver: Stock on-flash yocto-tiny kernel 3.8.7
    Transmitter: Galileo Debian image :
                 https://sourceforge.net/projects/galileodebian/
    3.8.7 kernel: On SPI-flash BSP kernel
    andy-v4: From your tree
             d13ffcf ('serial: 8250: attempt to keep Kconfig and
                       Makefile in order')
    tip-of-tree : 97f0090 ('Merge tag 'rproc-v4.7' of
                            git://github.com/andersson/remoteproc')

Results:

### Test0 ###

galileo dma andy-v4 9600 8n1 

root@galileo:~# time echo "abcdefghijklmnopqrstuvwxyz0123456789" >
/dev/ttyS0

real    0m0.060s
user    0m0.000s
sys     0m0.000s


galileo non-dma Linux 3.8.7 9600 8n1:

9600 8n1
root@galileo:~# time echo "abcdefghijklmnopqrstuvwxyz0123456789" >
/dev/ttyS0

real    0m0.051s
user    0m0.000s
sys     0m0.000s

galileo non-dma tip-of-tree 9600 8n1:

root@galileo:~# time echo "abcdefghijklmnopqrstuvwxyz0123456789" >
/dev/ttyS0

real    0m0.048s
user    0m0.000s
sys     0m0.000s


### Test1 ###

galileo dma andy-v4 9600 8n1:

root@galileo:~# time echo
"abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyz01234567
89abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyz0123456
789abcdefghijklmnopqrstuvwxyz0123456789" > /dev/ttyS0

real    0m0.209s
user    0m0.000s
sys     0m0.000s

galileo non-dma Linux 3.8.7 9600 8n1:

root@galileo:~# time echo
"abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyz01234567
89abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyz0123456
789abcdefghijklmnopqrstuvwxyz0123456789" > /dev/ttyS0

real    0m0.206s
user    0m0.000s
sys     0m0.000s


galileo non-dma tip-of-tree 9600 8n1:

root@galileo:~# time echo
"abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyz01234567
89abcdefghijklmnopqrstuvwxyz0123456789abcdefghijklmnopqrstuvwxyz0123456
789abcdefghijklmnopqrstuvwxyz0123456789" > /dev/ttyS0

real    0m0.199s
user    0m0.010s
sys     0m0.000s


---
bod

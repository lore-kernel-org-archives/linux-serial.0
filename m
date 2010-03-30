From: christian pellegrin <chripell-VaTbYqLCNhc@public.gmane.org>
Subject: Re: [PATCH v1 3/4] max3100: adds console
	support for MAX3100
Date: Tue, 30 Mar 2010 10:00:16 +0200
Message-ID: <cabda6421003300100o57cdef97na139f169ac30f200@mail.gmail.com>
References: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
	<1269340170-6558-1-git-send-email-chripell@fsfe.org>
	<20100329104838.49c18075@feng-i7>
	<cabda6421003282311x78051e1eq38ada68f2553609e@mail.gmail.com>
	<20100329150642.4a94e78a@feng-i7>
	<cabda6421003290555k70d13168y4beba2c3ae6e2ece@mail.gmail.com>
	<20100330101445.5c64dedb@feng-i7>
	<cabda6421003292349m2dd6125cp2bcc1060f5aa8741@mail.gmail.com>
	<20100330151904.30dd2a68@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100330151904.30dd2a68@feng-i7>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org" <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org" <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 30, 2010 at 9:19 AM, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> No words in my last email suggested to use dynamic SPI clock speed,
> I admited that method is brutal and not mature when my driver was
> reviewed. In early version of our 3110 driver, we don't use dynamic
> clock speed, but the maxim clock supports by 3110, while we still use
> 8 words buffer read for RX.
>
> Let me cut my question clear: why not use the 8 words RX HW fifo? For
> bulk RX in 230400 case, is 50us enough to handle controller IRQ +
> spi subsystem overhead + tty receive overhead for one char per spi
> transfer model?
>

For TX it's impossible. Before sending a char we have to check if T
bit says that the TX buffer is empty. Otherwise if SPI bus speed >
UART baud rate we will loose TX chars for sure. For RX maybe it might
be worth to always do 8 byte transfers and the look at R bit of
transfer i to see if we have a valid char in (i+1) instead of doing
single transfers. But here again we are fixing the insane latency per
start of transfer of the underlying SPI master controller. And let me
say that in the actual driver the 8 byte RX fifo *is* used: the loop
in max3100_ist drains RX buffer at a speed greater than the chars
coming (also at 115200). The 8-bytes RX buffer fills as a consequence
of delays in interrupt thread being awaken.

The tests I did with zmodem show that in the direction max3100 <- PC
has very good efficiency compared to max3100 -> PC. I guess the reason
is that the tx buffer is just 1 byte deep and we don't have any other
way to handle the T bit other than the do loop in max3100_ist. Maybe I
will try to do some instrumentation with systemtap to show this (it's
always nice to find some uses for systemtap). Anyway I'm sure that
it's always better to not loose chars being received than delaying
transmitted one for a bit.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev

From: Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] amba-pl011: simplify TX handling
Date: Wed, 18 Mar 2015 17:41:57 +0000
Message-ID: <20150318174157.GD3549@e103592.cambridge.arm.com>
References: <20150317163200.GE3759@e103592.cambridge.arm.com>
 <20150318004255.538fd48e@north>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150318004255.538fd48e@north>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Cc: Russell King <linux@arm.linux.org.uk>, Jakub Kicinski <kubakici@wp.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Karol Debogorski <k.debogorski@a2s.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andre Przywara <Andre.Przywara@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

From: Dave P Martin <Dave.Martin@arm.com>
To: Jakub Kicinski <moorray3@wp.pl>
CC: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Andre Przywara
 <Andre.Przywara@arm.com>, Karol Debogorski <k.debogorski@a2s.pl>, Jakub
 Kicinski <kubakici@wp.pl>
Subject: Re: [PATCH] amba-pl011: simplify TX handling

On Tue, Mar 17, 2015 at 11:42:55PM +0000, Jakub Kicinski wrote:
> On Tue, 17 Mar 2015 16:32:00 +0000, Dave P Martin wrote:

[...]

> > Many maintainers keep separate branches for sending to -next, so that
> > immature patches can get wider visibility before they accept them for
> > merging; a separate branch (called for-linus or similar) is often used
> > for sending pull requests to Linus.
> 
> OK, the reason I asked is that I come from the networking corner of the
> kernel where rebasing even -next trees is more frowned upon.  However,
> if we agree to merge my patch we could actually leave the tree as it
> is, I think most of your v1 -> v2 changes are overwritten anyway.

I guess I misread the tone of your question slightly... anyway I guess
it's up to Greg.

For now, I'll probably repost replacement patches and a delta, and he
can choose which to apply.


I'm aiming to repost tomorrow -- couldn't quite get to where I was
aiming for today.

More comments below.

> > Maybe you can drop some getnstimeofday() into pl011_int() and/or
> > pl011_tx_chars(), to collect some simple stats?
> > 
> > I might have a go at this if I get a moment -- but any info you
> > could obtain would be helpful.  For one thing, the behvaiour
> > might vary a bit between platforms, even for a fixed baud rate.
> 
> Unfortunately I had to give up trying to get perf to work on my RPi (I
> read somewhere that SOC does not have PMU properly connected?).  What I
> have instead are some simple, "proxy" numbers:
> 
> 1) First I measured how much more data can be loaded thanks to the FF
>    check at the end of guaranteed FIFO filling.  For 2Mbps I got
>    following numbers (transferring the same file):
> 
>           | FIFO loads | FF seen** | additional chars loaded |  
> no load   |   173350   |  169157   |         8429	     |
> 100% CPU* |   136757   |   50942   |       300375	     |
> 
> *  100% CPU utilization achieved by running iperf and UART traffic on
>    other chips;
> ** after guaranteed count FF was set - no additional chars loaded.
> 
> Breakdown of how many additional chars could be loaded per IRQ:
> 
>                1    2    3    4    5    6    7    8    9  10 ...
> no load  |  2094 1127  418  256  120   81   36   31   23   1 0 0 0 0 0 0
> 100% CPU | 33375 7336 6527 7324 7971 8586 6983 3387 4007   4 0 0 0 0 0 0
> 
> I also tested with 115kbps and only 5 times out of 30k checks IRQ was
> able to put in a single additional character on a fully loaded system.
> 
> 
> To sum up - on a fully loaded system FF check gives a significant (~20%)
> drop in the number of pl011_tx_chars() calls (but they are more costly).
> 
> 2) I run some CPU intensive and I/O intensive benchmarks to see the
>    effect doing FF check has on general performance:
> 
> w/read - check performed
>  /read - just load FIFO size/2; don't check FIFO_FULL
> 
> iperf  -c 10.1.1.16 -t 60  # [Mbps] usb ethernet stick
> clean:  49.3 49.2 49.3 49.4 49.4 
> w/read: 42.0 40.9 42.0 42.1 42.0
>  /read: 42.0 43.1 42.2 42.1 42.6
> 
> time echo "scale=1500; a(1)*5" | bc -l  # [s] of real time
> clean:  12.263 12.311 12.230 12.242 12.272
> w/read: 14.512 14.646 14.541 14.894 14.504
>  /read: 14.776 14.714 14.936 14.588 14.658
> 
> 
> This simple test indicates that not doing the check helps I/O
> performance but hurts the CPU computation speed.  The difference is not
> big in either case but since my heart lies with networking I will
> actually drop the FF check in v2 :)
> 
> I don't feel strongly about it though, let me know if you prefer to
> leave it in.

Thanks for looking into this -- it's interesting to see measurable
results, but overall I agree: this is an extreme case, and it looks
like we don't need to panic one war or the other.

My original instinct was to keep the original behaviour of only
sending the guaranteed number of chars on IRQ, so I guess we're
in agreement on this (though without strong feeling on either
side.)

[...]

> > It could happen in some hardware configurations too -- I once had an
> > embedded UART running at 3Mbps, fed by a 15MHz ARM7TDMI at one point.
> > Could have gone faster, but the FTDI uart at the other end of
> > the link used a different base clock, making it hard to match
> > the rates closely enough at high speeds.  Even on fast modern
> > platforms, DVFS may slow down the CPU quite aggressively on some
> > systems.
> 
> So the delayed work serves as TX watchdog.  I'm not convinced that we
> should add it if we have no report of hardware in the wild which needs
> it...  If we do add it - perhaps the watchdog should check all of the
> IRQs (e.g. RX IRQ delivery can fail as well)? 

Sure, I think it can be dropped.  It does not add much benefit for
that extreme case, and for more realistic cases it just adds complexity.

[...]

> > A system where feeding the UART really does take ~100%CPU really
> > has a design problem, which we can't expect to fix in the pl011
> > driver...
> 
> Agreed.

[...]

> This is exactly what I did:
> # stty -F /dev/ttyAMA0 115200 -onlcr
> # cat 1MB_text_file > /dev/ttyAMA0
> ^C
> Now AMA0 is dead.  If I waited until the whole file was written,
> everything was fine.  This was 100% reproducible and I later checked
> that on .shutdown() the FIFO was full (no IRQ pending yet).  Initially I
> tried to play around with CR programming on .shutdown() but it didn't
> change anything (according to Broadcom docs one should be very careful
> not to touch CR while UART is busy).

Interesting... I missed this because the systemd issue that got me
started on this only shows up of the console is on the PL011.  Once
a shell is running on ttyAMA0, the port is always open, so the effects
of shutting down and restarting the pl011 are not seen.

I'm actually suspicious of the correct behaviour here.  serial_core
waits for the UART to drain via uart_wait_until_sent(), but there are
some oddities:

 * The wait is abandoned early if there is a pending signal.  This
   means that some output already sent to the kernel via write() is
   is simply lost.  This feels a bit odd -- for all other I/O I can
   think of, write() does not guarantee that the data has reached
   its destination, but on return it usually does guarantee that the
   data _will_ reach its destination (except for unrecoverable I/O
   errors).

   This behaviour does mean that pl011_shutdown() is invoked with
   a non-empty FIFO if the only process with the port open is killed
   by a signal while output is pending, causing the hangup.

 * uart_wait_until_sent()'s timeout calculations aim to wait for
   no longer than it takes the FIFO to drain.  However, this function
   can get called when the serial_core xmit queue for the port is
   very non-empty -- meaning that the FIFO continues to be topped
   up for some time.  This can cause more data to be lost.


Since my "optimization" to hold TXIS asserted across _shutdown()..
_startup() was of questionable benefit in the first place I agree just
to drop it.

Cheers
---Dave

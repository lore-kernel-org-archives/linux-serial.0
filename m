From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH] amba-pl011: simplify TX handling
Date: Wed, 18 Mar 2015 00:42:55 +0100
Message-ID: <20150318004255.538fd48e@north>
References: <20150317163200.GE3759@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150317163200.GE3759@e103592.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave P Martin <Dave.Martin@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, Jakub Kicinski <kubakici@wp.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Karol Debogorski <k.debogorski@a2s.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andre Przywara <Andre.Przywara@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, 17 Mar 2015 16:32:00 +0000, Dave P Martin wrote:
> [Apologies for any duplicate mails received -- some MTAs keep
> choking on this.  Squshing to ASCII in case that helps.
> 
> [fixed typo'd address for linux-arm-kernel]
> 
> [Greg, to minimise confusion while these patches are still under
> discussion, can you drop the following patches from tty-next:
> 
>  * f2ee6df serial/amba-pl011: Leave the TX IRQ alone when the UART is not open
>  * 734745c serial/amba-pl011: Activate TX IRQ passively
> 
> You can pull in my updated series if you want, but at this point further
> changes are likely:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/330619.html
> 
> See below for context.]
> 
>> [...]
> 
> -next is an automated merge of lots of people's branches.  This helps
> give advance warning of changes that are likely to break the kernel,
> or each other.  Stuff in -next isn't necessarily accepted by anyone
> for actual merging yet.  All history can get rewritten until patches
> land in torvalds/master.
> 
> Many maintainers keep separate branches for sending to -next, so that
> immature patches can get wider visibility before they accept them for
> merging; a separate branch (called for-linus or similar) is often used
> for sending pull requests to Linus.

OK, the reason I asked is that I come from the networking corner of the
kernel where rebasing even -next trees is more frowned upon.  However,
if we agree to merge my patch we could actually leave the tree as it
is, I think most of your v1 -> v2 changes are overwritten anyway.

> > > Can you try to rebase?
> > >
> > > My update still keeps the softirq stuff.  I wanted to avoid adding
> > > status polling inside the interrupt handler's core loop, due to
> > > concerns about performance overhead: without the polling, the
> > > writes to DR are fire-and-forget, whereas polling FR each time
> > > involves a whole round-trip to the UART which may involve significant
> > > extra time cost and/or IRQ disable latency; however.
> > >
> > > Your approach does mitigate some of the cost by only starting to
> > > poll after count chars have been transmitted, and will typically
> > > halve the number of IRQs taken -- which could lead to a net benefit.
> > > It would be good to see some benchmarks to understand how much
> > > difference it makes to performance.
> > 
> > I will *try* to come up with some figures but I don't have any
> > high-speed UARTs so my tests run at 115k tops.  I think dropping the FF
> > poll at the end of load from IRQ could be a good idea.  And I have to
> > respin anyway because I just noticed I added a double new line in
> > pl011_tx_chars()...
> 
> Maybe you can drop some getnstimeofday() into pl011_int() and/or
> pl011_tx_chars(), to collect some simple stats?
> 
> I might have a go at this if I get a moment -- but any info you
> could obtain would be helpful.  For one thing, the behvaiour
> might vary a bit between platforms, even for a fixed baud rate.

Unfortunately I had to give up trying to get perf to work on my RPi (I
read somewhere that SOC does not have PMU properly connected?).  What I
have instead are some simple, "proxy" numbers:

1) First I measured how much more data can be loaded thanks to the FF
   check at the end of guaranteed FIFO filling.  For 2Mbps I got
   following numbers (transferring the same file):

          | FIFO loads | FF seen** | additional chars loaded |  
no load   |   173350   |  169157   |         8429	     |
100% CPU* |   136757   |   50942   |       300375	     |

*  100% CPU utilization achieved by running iperf and UART traffic on
   other chips;
** after guaranteed count FF was set - no additional chars loaded.

Breakdown of how many additional chars could be loaded per IRQ:

               1    2    3    4    5    6    7    8    9  10 ...
no load  |  2094 1127  418  256  120   81   36   31   23   1 0 0 0 0 0 0
100% CPU | 33375 7336 6527 7324 7971 8586 6983 3387 4007   4 0 0 0 0 0 0

I also tested with 115kbps and only 5 times out of 30k checks IRQ was
able to put in a single additional character on a fully loaded system.


To sum up - on a fully loaded system FF check gives a significant (~20%)
drop in the number of pl011_tx_chars() calls (but they are more costly).


2) I run some CPU intensive and I/O intensive benchmarks to see the
   effect doing FF check has on general performance:

w/read - check performed
 /read - just load FIFO size/2; don't check FIFO_FULL

iperf  -c 10.1.1.16 -t 60  # [Mbps] usb ethernet stick
clean:  49.3 49.2 49.3 49.4 49.4 
w/read: 42.0 40.9 42.0 42.1 42.0
 /read: 42.0 43.1 42.2 42.1 42.6

time echo "scale=1500; a(1)*5" | bc -l  # [s] of real time
clean:  12.263 12.311 12.230 12.242 12.272
w/read: 14.512 14.646 14.541 14.894 14.504
 /read: 14.776 14.714 14.936 14.588 14.658


This simple test indicates that not doing the check helps I/O
performance but hurts the CPU computation speed.  The difference is not
big in either case but since my heart lies with networking I will
actually drop the FF check in v2 :)

I don't feel strongly about it though, let me know if you prefer to
leave it in.

> > > Looping in pl011_tx_chars() until either the FIFO is full or
> > > we run out of chars to transmit gets rid of the need for the
> > > softirq, so I wouldn't be opposed to keeping that if the
> > > performance impact is not too significant.
> > 
> > TBH the softirq stuff I don't quite understand.  I had never seen it
> > fire in my tests.  Can you explain its purpose?  Is there HW out there
> > which fails to fire the IRQ (but it wouldn't work until now anyhow)?
> 
> At the moment it's partly theoretical: I have seen the TX IRQ fail
> to fire on some software models -- it's not that uncommon for
> a model not to bother emulating the actual transmission delay, so
> some effectively drain every char written to the FIFO instantly.
> 
> It could happen in some hardware configurations too -- I once had an
> embedded UART running at 3Mbps, fed by a 15MHz ARM7TDMI at one point.
> Could have gone faster, but the FTDI uart at the other end of
> the link used a different base clock, making it hard to match
> the rates closely enough at high speeds.  Even on fast modern
> platforms, DVFS may slow down the CPU quite aggressively on some
> systems.

So the delayed work serves as TX watchdog.  I'm not convinced that we
should add it if we have no report of hardware in the wild which needs
it...  If we do add it - perhaps the watchdog should check all of the
IRQs (e.g. RX IRQ delivery can fail as well)? 

> That said, my current approach of backing off and scheduling a
> softirq doesn't necessarily bring a lot of benefit.
> 
> The main difference is that writing a huge buffer to a UART with
> an unfillable TX FIFO will just leave execution stuck in pl011_int()
> holding the port lock for a long time until all the data has been
> sent.  But I think that would happen even with the original driver code
> -- TXIS would stay asserted, so pl011_int() would just keep calling
> _tx_chars() without releasing the port lock or returning.
> 
> I think I'll have a try at getting rid of the softirq, following
> your example, and see how things look.
> 
> A system where feeding the UART really does take ~100%CPU really
> has a design problem, which we can't expect to fix in the pl011
> driver...

Agreed.

> > > On port shutdown, the TX interrupt will be masked by IMSC, but should
> > > remain asserted inside the PL011, triggering an interrupt the next time
> > > it is unmasked.
> > > 
> > > If you observed something that conflicts with these assumptions,
> > > I'd be interested to know what's going on...
> > 
> > Actually seeing this bug in practice was what motivated this work.
> > I triggered it by catting a long file over the UART and then hitting
> > ^C.  UART died every time...  That being said I test this on BCM2708
> > which is also notorious for transmitting while device in loopback
> > configuration, so perhaps it's implementation-dependent...
> 
> Can you describe in more detail what you did?  I don't think that
> ^C should break things ever, but I'd like to try to reproduce it
> just in case there is some faulty logic somewhere...

This is exactly what I did:
# stty -F /dev/ttyAMA0 115200 -onlcr
# cat 1MB_text_file > /dev/ttyAMA0
^C
Now AMA0 is dead.  If I waited until the whole file was written,
everything was fine.  This was 100% reproducible and I later checked
that on .shutdown() the FIFO was full (no IRQ pending yet).  Initially I
tried to play around with CR programming on .shutdown() but it didn't
change anything (according to Broadcom docs one should be very careful
not to touch CR while UART is busy).

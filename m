From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] serial: Do not treat the IIR register as a bitfield
Date: Thu, 30 Mar 2017 20:18:00 +0800
Message-ID: <201703302036.mn7yu2Zn%fengguang.wu@intel.com>
References: <20170329184431.6226-1-oliver@schinagl.nl>
Reply-To: fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJ4N37Q6EERBNHP6PDAKGQEE5UVK4A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170329184431.6226-1-oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, Ed Blake <ed.blake-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jason Uy <jason.uy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Thor
List-Id: linux-serial@vger.kernel.org

Hi Olliver,

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on v4.11-rc4 next-20170330]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Olliver-Schinagl/serial-Do-not-treat-the-IIR-register-as-a-bitfield/20170330-165826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address': unknown attribute
   drivers/staging/media/lirc/lirc_sir.c:285:44: sparse: undefined identifier 'UART_IIR_ID'
   drivers/staging/media/lirc/lirc_sir.c:286:29: sparse: undefined identifier 'UART_IIR_ID'
>> drivers/staging/media/lirc/lirc_sir.c:287:22: sparse: incompatible types for 'case' statement
   drivers/staging/media/lirc/lirc_sir.c:290:22: sparse: incompatible types for 'case' statement
   drivers/staging/media/lirc/lirc_sir.c:293:22: sparse: incompatible types for 'case' statement
   drivers/staging/media/lirc/lirc_sir.c:299:22: sparse: incompatible types for 'case' statement
   drivers/staging/media/lirc/lirc_sir.c: In function 'sir_interrupt':
   drivers/staging/media/lirc/lirc_sir.c:285:37: error: 'UART_IIR_ID' undeclared (first use in this function)
     while ((iir = inb(io + UART_IIR) & UART_IIR_ID)) {
                                        ^~~~~~~~~~~
   drivers/staging/media/lirc/lirc_sir.c:285:37: note: each undeclared identifier is reported only once for each function it appears in

vim +/case +287 drivers/staging/media/lirc/lirc_sir.c

34668350 drivers/staging/media/lirc/lirc_sir.c Ksenija Stanojevic 2015-05-22  279  	ktime_t curr_time;
34668350 drivers/staging/media/lirc/lirc_sir.c Ksenija Stanojevic 2015-05-22  280  	static unsigned long delt;
34668350 drivers/staging/media/lirc/lirc_sir.c Ksenija Stanojevic 2015-05-22  281  	unsigned long deltintr;
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  282  	unsigned long flags;
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  283  	int iir, lsr;
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  284  
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26 @285  	while ((iir = inb(io + UART_IIR) & UART_IIR_ID)) {
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  286  		switch (iir&UART_IIR_ID) { /* FIXME toto treba preriedit */
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26 @287  		case UART_IIR_MSI:
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  288  			(void) inb(io + UART_MSR);
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  289  			break;
404f3e95 drivers/staging/lirc/lirc_sir.c       Jarod Wilson       2010-07-26  290  		case UART_IIR_RLSI:

:::::: The code at line 287 was first introduced by commit
:::::: 404f3e956bc7ab03ac604fabf136e69607315f60 V4L/DVB: staging/lirc: add lirc_sir driver

:::::: TO: Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
:::::: CC: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH -repost] kgdb: depends on VT
Date: Thu, 31 Mar 2016 07:01:45 -0500
Message-ID: <56FD11A9.1060305@windriver.com>
References: <1459412955-4696-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
In-Reply-To: <1459412955-4696-1-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: Jiri Slaby <jslaby@suse.cz>, akpm@linux-foundation.org
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/31/2016 03:29 AM, Jiri Slaby wrote:
> With VT=n, the kernel build fails with:
> drivers/built-in.o: In function `kgdboc_pre_exp_handler':
> kgdboc.c:(.text+0x7b5aa): undefined reference to `fg_console'
> kgdboc.c:(.text+0x7b5ce): undefined reference to `vc_cons'
> kgdboc.c:(.text+0x7b5d5): undefined reference to `vc_cons'
>
> kgdboc.o is built when KGDB_SERIAL_CONSOLE is set. So make
> KGDB_SERIAL_CONSOLE depend on HW_CONSOLE which includes those symbols.

Acked-by: Jason Wessel <jason.wessel@windriver.com>


I'll put this in the kgdb-next branch and submit it to the upstream, unless it gets merged in another queue.

Thanks!
Jason.

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785471&iu=/4140

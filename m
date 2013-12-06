From: James Cameron <quozl@laptop.org>
Subject: Re: [PATCH] serial: rewrite pxa2xx-uart to use 8250_core
Date: Fri, 6 Dec 2013 11:38:51 +1100
Message-ID: <20131206003851.GI16425@us.netrek.org>
References: <20131205043544.GA28580@kroah.com>
 <1386286149-2855-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1386286149-2855-1-git-send-email-ynvich@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Ianovich <ynvich@gmail.com>
Cc: "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Rob Herring <rob.herring@calxeda.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Zhou Zhu <zzhu3@marvell.com>, Jiri Slaby <jslaby@suse.cz>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, John Crispin <blogic@openwrt.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Dec 06, 2013 at 03:28:37AM +0400, Sergei Ianovich wrote:
> pxa2xx-uart was a separate uart platform driver. It was declaring
> the same device names and numbers as 8250 driver. As a result,
> it was impossible to use 8250 driver on PXA SoCs.
> 
> Upon closer examination pxa2xx-uart turned out to be a clone of
> 8250_core driver.

I'm testing this backported to 3.5 on the OLPC XO-4 [1] [2].

As Russell says, the getty had to change, but after that the shell
worked fine; no more or no less responsive.

What hasn't worked yet is the console; no kernel messages appear.  I
have tried changing command line to console=ttyS0,115200.

1.  http://dev.laptop.org/~quozl/y/1VojGn.txt (diff relative to
olpc-kernel/arm-3.5)

2.  http://dev.laptop.org/~quozl/z/1VojLz.txt (dmesg)

-- 
James Cameron
http://quozl.linux.org.au/

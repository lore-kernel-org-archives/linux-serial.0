From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/1] staging: Add firewire-serial driver
Date: Tue, 23 Oct 2012 20:41:11 +0200
Message-ID: <20121023204111.63e13986@stein>
References: <1350565015.23730.4.camel@thor> <20121022224505.GD24489@kroah.com>
	<1350959679.2621.55.camel@thor>
	<20121023105140.5996c3a5@pyramind.ukuu.org.uk>
	<1351009822.2621.158.camel@thor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1351009822.2621.158.camel@thor>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Peter Hurley <peter@hurleysoftware.com>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

On Oct 23 Peter Hurley wrote:
> most controllers allow spillover into
> the portion of bus cycle assigned for sync tx (which is another 4Kbytes
> per 125us).

All controllers do so and are expected to do so.  Asynchronous traffic is
not supposed to depend on a cycle master being active.

> (Technical note: the actual total max for combined async
> and sync tx is 6144 bytes per 125us clock)

It depends on bus topology, transaction types, and more.  For a single-hop
S400 1394a bus (vulgo FireWire 400) I once calculated 44 MB/s bandwidth of
asynchronous unified write transactions:
http://marc.info/?l=linux1394-devel&m=109128028930225
That's at the physical layer; link layer and application layer performances
are less than that of course.
-- 
Stefan Richter
-=====-===-- =-=- =-===
http://arcgraph.de/sr/

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct

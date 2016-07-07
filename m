From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2] serial: amba-pl011: complete support to ZTE uart
Date: Thu, 7 Jul 2016 23:01:07 +0800
Message-ID: <20160707150107.GA20896@tiger>
References: <1458717126-20814-1-git-send-email-jun.nie@linaro.org>
 <CABymUCN_Os0gxoWjfwB_8V4kEkwBqKcrCCRjH8+-gm-Xt3-tYQ@mail.gmail.com>
 <570CF1B3.8080305@linaro.org>
 <CABymUCPvayLkc5h-3e0671pEEO_SshNJazk7W0B_oAUfL-6r0w@mail.gmail.com>
 <20160428201106.GA2924@kroah.com>
 <CABymUCPH1CwxhBxGq5_epgn-19j9WrfrxxG8zuzpZnXk26Ps9A@mail.gmail.com>
 <20160707095453.GA10000@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160707095453.GA10000@tiger>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jun Nie <jun.nie@linaro.org>, Russell King <linux@armlinux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, G Gregory <graeme.gregory@linaro.org>, Jason Liu <jason.liu@linaro.org>, Greg KH <greg@kroah.com>, Timur Tabi <timur@codeaurora.org>, linux-serial@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 07, 2016 at 05:54:53PM +0800, Shawn Guo wrote:
> On Mon, May 16, 2016 at 10:31:37AM +0800, Jun Nie wrote:
> > >> > Russell,
> > >> >
> > >> > Do you have any comments to these change?
> > >> >
> > >> > Jun
> > >>
> > >> Greg,
> > >>
> > >> Do you have any idea on how to drive review on this patch? Seems
> > >> maintainer Russell is too busy and missing for this thread and others
> > >> do not have comments. Your comments are appreciated!
> > >
> > > I would like to get Russell's opinion of this before merging it.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > Russell,
> > 
> > Could you help have a look at this patch? Thanks!
> 
> Hi Russell,
> 
> I think this version of the patch is trying to address the comment you
> put on v1, i.e. instead of extending platform driver we should try to
> probe ZTE UART from AMBA bus.
> 
> The solution here is to fake a AMBA peripheral ID which does not exist
> on hardware with a magic number.  While it's working, it looks too
> hackish, and doesn't really scale in the long run.  I hope that's also
> the reason you are unwilling to provide your ACK :)
> 
> Unless you have a better solution to suggest, I would think that
> platform driver is a sensible way to support the device, and will go
> back to v1 approach.

Just found that Russell's email address changed.  Resend to the new
address.

Shawn

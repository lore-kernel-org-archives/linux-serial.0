From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/9] serial: Add Tegra Combined UART driver
Date: Mon, 12 Nov 2018 10:03:01 -0800
Message-ID: <20181112180301.GB28739@kroah.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <20181026111638.10759-8-thierry.reding@gmail.com>
 <20181109170526.GB14151@kroah.com>
 <20181112153014.GA29481@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112153014.GA29481@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Jiri Slaby <jslaby@suse.com>, Mikko Perttunen <mperttunen@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>, Mika Liljeberg <mliljeberg@nvidia.com>, linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 12, 2018 at 04:30:14PM +0100, Thierry Reding wrote:
> On Fri, Nov 09, 2018 at 09:05:26AM -0800, Greg Kroah-Hartman wrote:
> > On Fri, Oct 26, 2018 at 01:16:36PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> > > multiplexing multiple "virtual UARTs" into a single hardware serial
> > > port. The TCU is the primary serial port on Tegra194 devices.
> > > 
> > > Add a TCU driver utilizing the mailbox framework, as the used mailboxes
> > > are part of Tegra HSP blocks that are already controlled by the Tegra
> > > HSP mailbox driver.
> > > 
> > > Based on work by  Mikko Perttunen <mperttunen@nvidia.com>.
> > > 
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thanks. I just sent out v2 addressing Pekka's comments on the series.
> But I'm slightly confused now. Are you expecting anyone else to pick
> this up? There are technically no build time dependencies between any
> of these patches, so it should be fine to pick them all into the
> corresponding subsystem trees.

Ah, I thought there was a built-time dependancy, that's why I gave my
ack.

> Perhaps the only thing to note is that there is a runtime dependency
> from this patch on patches 1 and 2 in the series. Patch 1 is required to
> make blocking a mailbox possible in interrupt context, which we need in
> the TCU driver because the TTY and console paths do end up calling the
> mbox_send_message() from interrupt context. Patch 2 is only required at
> runtime if the two mailboxes are provided by different instances of the
> HSP block (which they are for TCU on Tegra194).
> 
> Would you prefer for Jassi to pick up the TCU patch along with the
> mailbox core and driver changes so that we deal with the runtime
> dependencies that way?
> 
> Alternatively, if Jassi is okay with the mailbox changes, I can pick up
> all of the v2 series of the patches into stable branches for v4.21, deal
> with the dependencies there and send out pull requests for everyone to
> merge into their subsystem trees.

I don't really care either way, whatever is easiest for you all is fine
with me.

thanks,

greg k-h

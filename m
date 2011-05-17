From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 0/2] tty/serial: Add PORT_TEGRA, fix break handling for
 it
Date: Tue, 17 May 2011 12:44:00 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04986AAAE1@HQMAIL01.nvidia.com>
References: <1305660466-4704-1-git-send-email-swarren@nvidia.com>
 <20110517193836.GA6912@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110517193836.GA6912-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Greg KH wrote at Tuesday, May 17, 2011 1:39 PM:
> On Tue, May 17, 2011 at 01:27:44PM -0600, Stephen Warren wrote:
> > 8250.c needs a specific PORT_TEGRA type for two reasons:
> > * RTOIE bit needs to be set, but UUE is reserved, so split RTOIE handling
> >   out of PORT_XSCALE.
> > * A WAR is needed for break reception.
> >
> > I'd like to get the first of these two patches merged into the tegra
> > arch for-next branch, so that I can modify the board files to explicitly
> > request the new port type rather than relying on auto-detection. As such,
> > could you please create a branch for that/these changes, then merge it
> > into tty-2.6.git, so that the same branch can be merged into Tegra's
> > for-next branch. Thanks.
> 
> No, I really don't want to create a separate branch for just 2 patches,
> a whole 43 lines modified, that's pretty useless.
> 
> If Alan acks these, I'll be glad to take them through the serial tree as
> normal, or you can take them through the tegra tree.

Hmm. OK; I thought this was standard practice, based on my experiences with
other subsystems.

I guess I'll opt for you just taking these through your tree then.

Thanks.

-- 
nvpublic

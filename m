From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2 0/7] tty: xuartps: Rebranding + DT documentation
Date: Tue, 11 Mar 2014 11:29:13 -0700
Message-ID: <b4e6dfe6-ad49-4d81-855b-8dd905665616@VA3EHSMHS039.ehs.local>
References: <1394487610-2419-1-git-send-email-soren.brinkmann@xilinx.com>
 <531EE993.80400@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <531EE993.80400@monstr.eu>
Sender: linux-doc-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Michal Simek <michal.simek@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2014-03-11 at 11:46AM +0100, Michal Simek wrote:
> On 03/10/2014 10:40 PM, Soren Brinkmann wrote:
> > Hi,
> >=20
> > this series rebrands the Xilinx PS UART driver as Cadence UART and
> > documents its DT bindings (+ some clean up along the way).
> >=20
> > The rebranding goes as far as reasonable. Things like file name, kc=
onfig
> > symbols and other things with user space impact are left as is. Ple=
ase
> > refer to the discussion in the RFC threads[1-2] for more details.
> >=20
> > Similar the DT binding has been extended. In addition to the new an=
d
> > preferred Cadence binding, the current xuartps binding is maintaine=
d.
> > Though, only the Cadence names for clock-names are documented.
> >=20
> > References:
> >  [1]  https://lkml.org/lkml/2014/3/4/405
> >  [2]  https://lkml.org/lkml/2014/3/7/450
> >=20
> > v2:
> >  - no changes regarding the patches
> >  - fixed (I sincerely hope) email recipients
> >=20
> > Changes from the latest RFC:
> >  - squashed function/symbol renaming into 'tty: xuartps: Rebrand dr=
iver
> >    as Cadence UART'
> >  - Revised the commit message of 'tty: xuartps: Don't write IRQ dis=
able
> >    register to enable interrupts' (was 'tty: xuartps: Remove bogus
> >    comment and register write'
>=20
> One more thing. I was thinking this is based on my 3 patches I have
> already sent to mainline. But as I see they are not applied yet.
>=20
> https://lkml.org/lkml/2014/1/21/107

I think my cleanup patch covers these changes as well. I'll see if it
makes sense to separate out this patch.

> https://lkml.org/lkml/2014/1/21/101

This is obsolete with the rebranding, IMHO.

> http://www.spinics.net/lists/arm-kernel/msg302796.html

I can add this to this series.

	S=C3=B6ren



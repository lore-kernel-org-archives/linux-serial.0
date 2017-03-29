From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv3 00/10] Nokia H4+ support
Date: Wed, 29 Mar 2017 16:17:05 -0500
Message-ID: <CAL_JsqJcQ9ANtt71KRitOJ9spKD1SaeoL4RDftiCEPs8TjLJGA@mail.gmail.com>
References: <20170328155939.31566-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170328155939.31566-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 28, 2017 at 10:59 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> Here is PATCHv3 for the Nokia bluetooth patchset. I addressed all comments from
> Rob and Pavel regarding the serdev patches and dropped the *.dts patches, since
> they were queued by Tony. I also changed the patch order, so that the serdev
> patches come first. All of them have Acked-by from Rob, so I think it makes
> sense to merge them to serdev subsystem (now) and provide an immutable branch
> for the bluetooth subsystem.

Greg doesn't read cover letters generally and since the serdev patches
are Cc rather than To him, he's probably not planning to pick them up.

Rob

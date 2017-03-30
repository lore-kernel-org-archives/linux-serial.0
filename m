From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH] serial: tegra: Map the iir register to default defines
Date: Thu, 30 Mar 2017 17:37:41 +0200
Message-ID: <0DEBCDAD-C7D3-4DB9-B5F5-408951165662@schinagl.nl>
References: <20170329184806.6577-1-oliver@schinagl.nl> <9eed3c8e-a7af-1e1f-659a-a092a89d1679@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9eed3c8e-a7af-1e1f-659a-a092a89d1679@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hey Jon,

On March 30, 2017 3:42:19 PM CEST, Jon Hunter <jonathanh@nvidia=2Ecom> wro=
te:
>
>On 29/03/17 19:48, Olliver Schinagl wrote:
>> The tegra serial IP seems to be following the common layout and the
>> interrupt ID's match up nicely=2E Replace the magic values to match the
>> common serial_reg defines, with the addition of the Tegra unique End
>of
>> Data interrupt=2E
>>=20
>> Signed-off-by: Olliver Schinagl <oliver@schinagl=2Enl>
>> ---
>> Note I do not own any tegra hardware and just noticed it while
>working on my
>> somewhat related previous patch,
>> "serial: Do not treat the IIR register as a bitfield"
>>=20
>> As such, this patch can only be applied after the aforementioned
>patch or the
>> iir variable will not have its mask applied yet=2E
>
>Nit-pick=2E If this is the case, then this should really be part of a
>patch series so it is obvious to everyone that this should only be
>applied after the other patch=2E
Yes, and it was, but I did not want to have the really big list of names i=
n this much smaller group=2E
>
>Cheers
>Jon

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual topology
Date: Sun, 24 Jan 2016 22:38:57 +0000
Message-ID: <yw1xk2myli0u.fsf@unicorn.mansr.com>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
	<1453663322-14474-4-git-send-email-mans@mansr.com>
	<20160124223629.GI6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20160124223629.GI6588@sirena.org.uk> (Mark Brown's message of
	"Sun, 24 Jan 2016 22:36:29 +0000")
Sender: linux-ide-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Sun, Jan 24, 2016 at 07:21:50PM +0000, Mans Rullgard wrote:
>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>=20
>> The source and destination masters are reflecting buses or their lay=
ers to
>> where the different devices can be connected. The patch changes the =
master
>> names to reflect which one is related to which independently on the =
transfer
>> direction.
>
> This is patch 3 of a series but I don't have anything else in the
> series.  What is going on with the rest of the series - what are the
> dependencies and so on?

I give up.  Seriously, this is impossible.  If I don't include everybod=
y
in the slightest way related to any patch in the series, I get
complaints that patches are missing.  If I do, the lists reject it all
due to too many recipients.  What the hell am I supposed to do?

--=20
M=E5ns Rullg=E5rd

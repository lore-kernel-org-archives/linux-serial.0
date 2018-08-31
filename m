From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 02/18] clk: intel: Add clock driver for Intel MIPS SoCs
Date: Fri, 31 Aug 2018 10:13:05 -0700
Message-ID: <153573558557.93865.3835503209987304514@swboyd.mtv.corp.google.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-3-songjun.wu@linux.intel.com>
 <153370742214.220756.2039365625963765922@swboyd.mtv.corp.google.com>
 <571d2d40-8728-fa7c-5d89-73d2a7b6293b@linux.intel.com>
 <153539697928.129321.2605078315090527674@swboyd.mtv.corp.google.com>
 <65a8518b-8fd8-847b-f952-0370be3d786a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <65a8518b-8fd8-847b-f952-0370be3d786a@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zhu, Yi Xin" <yixin.zhu@linux.intel.com>, Songjun Wu <songjun.wu@linux.intel.com>, chuanhua.lei@linux.intel.com, hua.ma@linux.intel.com, qi-ming.wu@intel.com
Cc: linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-serial@vger.kernel.org

Quoting Zhu, Yi Xin (2018-08-29 03:34:26)
> >>>> +}
> >>>> +
> >>>> +CLK_OF_DECLARE(intel_grx500_cgu, "intel,grx500-cgu", grx500_clk_ini=
t);
> >>> Any reason a platform driver can't be used instead of CLK_OF_DECLARE(=
)?
> >> It provides CPU clock which is used in early boot stage.
> >>
> > Ok. What is the CPU clock doing in early boot stage? Some sort of timer
> > frequency? If the driver can be split into two pieces, one to handle the
> > really early stuff that must be in place to get timers up and running
> > and the other to register the rest of the clks that aren't critical from
> > a regular platform driver it would be good. That's preferred model if
> > something is super critical.
> >
> Just to make sure my approach is same as you think.
> =

> In the driver, there's two clock registrations.
> =

> - One through CLK_OF_DECLARE for early stage clocks.
> =

> - The other via platform driver for the non-critical clocks.

You can use the same DT node for both parts, no need to split the node
into two and use syscon here.

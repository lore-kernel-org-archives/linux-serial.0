From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH 09/13] clk: exynos5420: register clocks using common clock framework
Date: Thu, 13 Jun 2013 10:48:13 +0530
Message-ID: <CANuQgHHxkK2UOWZBgTPzRN_vo02MFRmFYUn9KqJftJ17xrAMfg@mail.gmail.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
	<1370516488-25860-9-git-send-email-chander.kashyap@linaro.org>
	<1479353.W3tSzhFHaA@flatron>
	<CAL1qeaE91S-sTLXBb7d3tbDP9M68py4PsLdHxxp2JqisGsP=ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAL1qeaE91S-sTLXBb7d3tbDP9M68py4PsLdHxxp2JqisGsP=ww@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>
List-Id: linux-serial@vger.kernel.org

On 13 June 2013 03:02, Andrew Bresticker <abrestic@chromium.org> wrote:
> Tomasz,
>
>>> +     apll = samsung_clk_register_pll35xx("fout_apll", "oscclk",
>>> +                     reg_base + 0x100);
>>> +     bpll = samsung_clk_register_pll35xx("fout_bpll", "oscclk",
>>> +                     reg_base + 0x20110);
>>> +     cpll = samsung_clk_register_pll35xx("fout_cpll", "oscclk",
>>> +                     reg_base + 0x10120);
>>> +     dpll = samsung_clk_register_pll35xx("fout_dpll", "oscclk",
>>> +                     reg_base + 0x10128);
>>> +     epll = samsung_clk_register_pll35xx("fout_epll", "oscclk",
>>> +                     reg_base + 0x10130);
>>> +     ipll = samsung_clk_register_pll35xx("fout_ipll", "oscclk",
>>> +                     reg_base + 0x10150);
>>> +     kpll = samsung_clk_register_pll35xx("fout_kpll", "oscclk",
>>> +                     reg_base + 0x28100);
>>> +     mpll = samsung_clk_register_pll35xx("fout_mpll", "oscclk",
>>> +                     reg_base + 0x10180);
>>> +     rpll = samsung_clk_register_pll35xx("fout_rpll", "oscclk",
>>> +                     reg_base + 0x10140);
>>> +     spll = samsung_clk_register_pll35xx("fout_spll", "oscclk",
>>> +                     reg_base + 0x10160);
>>> +     vpll = samsung_clk_register_pll35xx("fout_vpll", "oscclk",
>>> +                     reg_base + 0x10170);
>>
>> Are all those PLLs really PLL35xx? At least for VPLL and EPLL a PLL
>> without the K factor looks a bit awkward.
>
> No they are not...  EPLL and RPLL should be pll36xx, but the rest are pll35xx.
Yes EPLL and RPLL are pll36xx.
Thanks for pointing out.
>
> Thanks,
> Andrew



--
with warm regards,
Chander Kashyap

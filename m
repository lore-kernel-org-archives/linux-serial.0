From: sunil joshi <sjoshi.open@gmail.com>
Subject: Re: [PATCH 09/13] clk: exynos5420: register clocks using common clock framework
Date: Mon, 10 Jun 2013 16:42:08 +0530
Message-ID: <CANruHrT_AVaQ0KAVkt6U0oS2_sz=2vmZn7KitNbQk96u7F4CSw@mail.gmail.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
	<1370516488-25860-9-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1370516488-25860-9-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com, Thomas Abraham <thomas.abraham@linaro.org>, dianders@chromium.org
List-Id: linux-serial@vger.kernel.org

Hi Chander,

[snip]

> +  sclk_uart3           131
> +  sclk_mmc0            132
> +  sclk_mmc1            132
> +  sclk_mmc2            133

above 2 numbers got repeated. Doug had found this in chromium tree and
fixed it. [ https://gerrit.chromium.org/gerrit/#/c/56626/]

Pls fix the typo in next version.

Regards
Sunil

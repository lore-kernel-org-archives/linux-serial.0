From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
Date: Wed, 26 Dec 2018 10:35:27 +0900
Message-ID: <9fba4689-b20f-c18a-ea11-d961de497ea3@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hi

On 2018/11/30 17:31, Stephen Boyd wrote:
>> +       init.num_parents = parents;
>> +       init.parent_names = parent_names;
>> +
>> +       mcm->cname = clk_name;
>> +       mcm->parent = 0;
>> +       mcm->hw.init = &init;
>> +
>> +       clk = clk_register(NULL, &mcm->hw);
>> +       if (IS_ERR(clk))
>> +               goto err_clk;
>> +
>> +       of_clk_add_provider(node, of_clk_src_simple_get, clk);
>> +       return;
>> +
>> +err_clk:
>> +       kfree(mcm);
>> +err_mcm:
>> +       kfree(parent_names);
>> +}
>> +CLK_OF_DECLARE(m10v_clk_mux, "socionext,milbeaut-m10v-clk-mux",
>> +                       m10v_clk_mux_setup);
> 
> Any chance you can use a platform driver?
> 

Excuse me to re-ask you.
Why do you recommend to use a platform driver? Is that current fad?

Thanks
Sugaya Taichi

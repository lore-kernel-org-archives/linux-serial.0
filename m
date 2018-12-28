From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
Date: Fri, 28 Dec 2018 15:38:58 +0900
Message-ID: <0c8db56a-6738-e003-5088-0c13588f695a@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
 <9fba4689-b20f-c18a-ea11-d961de497ea3@socionext.com>
 <154595756614.179992.794211301759568891@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154595756614.179992.794211301759568891@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org

Hi

On 2018/12/28 9:39, Stephen Boyd wrote:
> Quoting Sugaya, Taichi (2018-12-25 17:35:27)
>> Hi
>>
>> On 2018/11/30 17:31, Stephen Boyd wrote:
>>>> +       init.num_parents = parents;
>>>> +       init.parent_names = parent_names;
>>>> +
>>>> +       mcm->cname = clk_name;
>>>> +       mcm->parent = 0;
>>>> +       mcm->hw.init = &init;
>>>> +
>>>> +       clk = clk_register(NULL, &mcm->hw);
>>>> +       if (IS_ERR(clk))
>>>> +               goto err_clk;
>>>> +
>>>> +       of_clk_add_provider(node, of_clk_src_simple_get, clk);
>>>> +       return;
>>>> +
>>>> +err_clk:
>>>> +       kfree(mcm);
>>>> +err_mcm:
>>>> +       kfree(parent_names);
>>>> +}
>>>> +CLK_OF_DECLARE(m10v_clk_mux, "socionext,milbeaut-m10v-clk-mux",
>>>> +                       m10v_clk_mux_setup);
>>>
>>> Any chance you can use a platform driver?
>>>
>>
>> Excuse me to re-ask you.
>> Why do you recommend to use a platform driver? Is that current fad?
> 
> Not exactly a fad. We've been doing it for some time now. From an older
> email on the list:
> 
> Reasons (in no particular order):
> 
>    1. We get a dev pointer to use with clk_hw_register()
> 
>    2. We can handle probe defer if some resource is not available
> 
>    3. Using device model gets us a hook into power management frameworks
>       like runtime PM and system PM for things like suspend and hibernate
> 
>    4. It encourages a single DT node clk controller style binding
>       instead of a single node per clk style binding
> 
>    5. We can use non-DT specific functions like devm_ioremap_resource() to map
>       registers and acquire other resources, leading to more portable and
>       generic code
> 
>    6. We may be able to make the device driver a module, which will
>       make distros happy if we don't have to compile in all
>       these clk drivers to the resulting vmlinux
> 

Great thanks for answering. I strongly understand.
#It takes a bit of time to send v2.

Best Regards,
Sugaya Taichi

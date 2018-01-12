From: Ed Blake <ed.blake@sondrel.com>
Subject: Re: [PATCH] 8250_dw: do not int overflow when rate can not be aplied
Date: Fri, 12 Jan 2018 13:33:22 +0000
Message-ID: <48ee75ee-2d3a-c299-4ed8-23eb9ea27666@sondrel.com>
References: <20180111133832.13125-1-nunojpg@gmail.com>
 <57ef28bd-41da-73c2-3004-f9b2ecd8b102@sondrel.com>
 <CAEXMXLTYFbBraCNHyfc6JpCFwUMVqPeEanCufbKkgW2At7=d0Q@mail.gmail.com>
 <60dd87e2-ea07-5da3-f426-f39ef3c1addf@sondrel.com>
 <CAEXMXLRV27_GqbiRfGzc+pWLuytw3CesVuN6WdVAUhWvA6zkUQ@mail.gmail.com>
 <4fc98be4-e489-20f0-d899-e5eabdbd5e9d@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4fc98be4-e489-20f0-d899-e5eabdbd5e9d@sondrel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Nuno_Gon=c3=a7alves?= <nunojpg@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/01/18 18:03, Ed Blake wrote:
> On 11/01/18 17:55, Nuno Gonçalves wrote:
>> So, for me clk_round_rate() always returns 24000000, and only the loop
>> variable i changes, so the search is monotonic, from the highest baud
>> to the lowest (increasing divider).
>>
>> I am using a Allwiner H2+, with the serial port configuration from
>> sunxi-h3-h5.dtsi.
>>
>> Are you sure that clk_round_rate can return differet values? Is that
>> because some boards might have several clock options beside the
>> adjustable divider?
> Yes I'm sure.  Some platforms allow the clock rate to be varied, hence
> the existence of clk_round_rate() and clk_set_rate().
>
>> I really need to understand what is the problem, to be able to suggest
>> a solution to the integer overflow that is being allowed to happen.
> Some sort of overflow check on i * max_rate could work?

Actually I have another suggestion.  I'll submit a separate patch.

-- 
Ed

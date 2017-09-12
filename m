From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH repost v2] serial: sh-sci: document R8A77970 bindings
Date: Tue, 12 Sep 2017 20:13:52 +0300
Message-ID: <646bfb14-b768-3c3b-7512-4abdfae5a3f9@cogentembedded.com>
References: <20170901221519.704978317@cogentembedded.com>
 <20170912164714.3x5hjmkasdjhninp@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170912164714.3x5hjmkasdjhninp@rob-hp-laptop>
Content-Language: en-MW
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello!

On 09/12/2017 07:47 PM, Rob Herring wrote:

>> R-Car V3M (R8A77970) SoC also has the R-Car gen3 compatible SCIF and HSCIF
>> ports, so document the SoC specific bindings.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> This patch is against the 'tty-next' branch of GregKH's 'tty.git' repo.
> 
> So I guess you want Greg to apply because it doesn't apply to my tree.
> It's only a binding change, so not really any reason Greg has to take
> it.

    The MAINTAINERS file explicitly lists 
Documentation/devicetree/bindings/serial/ as Greg's area.

> Acked-by: Rob Herring <robh@kernel.org>

   Thanks!

[...]

> Rob

MBR, Seregi

From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial:8250:8250_pci: delete unneeded quirk entries
Date: Mon, 9 Mar 2015 11:31:02 +0200
Message-ID: <CAHp75VebU_-EUGU6_nQuK054G5PnLvdJ-=C7dBNk6aNSoKgW+Q@mail.gmail.com>
References: <20150306170835.GA1990@udknight>
	<54FA1A50.1000404@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54FA1A50.1000404@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Wang YanQing <udknight@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 6, 2015 at 11:21 PM, Bryan O'Donoghue
<pure.logic@nexus-software.ie> wrote:
> On 06/03/15 17:08, Wang YanQing wrote:
>>
>> These quirk entries have the same effect as default
>> quirk entry, so we can just delete them.
>>
>> Signed-off-by: Wang YanQing <udknight@gmail.com>
>
>
> ACK - does exactly what it says on the tin.
>
> Tested-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>

Guys, the idea was as far as I remember to keep this placeholder to
introduce DMA support later.
Now it brought an additional effort to be done for that.

-- 
With Best Regards,
Andy Shevchenko

From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/2] serial: Add name field to uart_port
Date: Thu, 23 Mar 2017 19:07:36 +0200
Message-ID: <CAHp75VddNYAROipDxjYuyCDRjTfyUoadXCSz88r6AAJ_gZQD6g@mail.gmail.com>
References: <20170321133636.8814-1-vigneshr@ti.com> <CAHp75VdhHj-7Utganxo1YnSABmnM5KC+bVJe2KgXx65hNHNGng@mail.gmail.com>
 <21173bda-55e5-b9d0-5eb1-335091fbca6a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21173bda-55e5-b9d0-5eb1-335091fbca6a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 23, 2017 at 2:22 PM, Vignesh R <vigneshr@ti.com> wrote:
> On Thursday 23 March 2017 12:16 AM, Andy Shevchenko wrote:
>> On Tue, Mar 21, 2017 at 3:36 PM, Vignesh R <vigneshr@ti.com> wrote:
>>> This series adds name attribute to uart_port struct inorder to store
>>> name of the tty port that will help in identify different uart
>>> instances.
>>> This patch series is based on discussion here[1].
>>
>> Please, use versioning for the series. This AFAIU should be v3, and
>> next (which is expecting based on comments) would be v4.
>
> The very first patch I submitted was accepted. So I did not make the
> previous patch as v2 as it was an incremental fix. Since, this series is
> very different from previous patch, I chose not to label this as v3.

Fair enough.

> Anyways, will make the next version as v4.

No need, then it makes sense to mark it as v2.

-- 
With Best Regards,
Andy Shevchenko

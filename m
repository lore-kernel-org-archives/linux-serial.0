From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 6/6] tty: serial: lpuart: add a more accurate baud rate
 calculation method
Date: Fri, 9 Jun 2017 18:48:30 +0300
Message-ID: <CAHp75VdgLoavZrf+T1-cyPj2A30mGeyDEgye3qZoWXJE6inE_Q@mail.gmail.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-7-git-send-email-aisheng.dong@nxp.com> <CAHp75Vemc5qoD7gbc_sJBSasYTFYSYOuWZv4N-4X60arWX8aJg@mail.gmail.com>
 <AM3PR04MB3062F7BCE82860C377C214E80F10@AM3PR04MB306.eurprd04.prod.outlook.com>
 <CAHp75VcH0j3ddaZ3iStNO4QcAwJKZ7BAMwUTthum2no1ucs2ww@mail.gmail.com>
 <AM3PR04MB306214514B820D66535E28B80CE0@AM3PR04MB306.eurprd04.prod.outlook.com>
 <CAHp75VcSToSfbUZ2TP0OsLRjV4TNpq7D_=4tnB_+rDvS2jp22Q@mail.gmail.com> <AM3PR04MB30678CBD87777C6816DEFA580CE0@AM3PR04MB306.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM3PR04MB30678CBD87777C6816DEFA580CE0@AM3PR04MB306.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "A.S. Dong" <aisheng.dong@nxp.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Duan <fugang.duan@nxp.com>, Stefan Agner <stefan@agner.ch>, Mingkai Hu <mingkai.hu@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>, Dong Aisheng <dongas86@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 9, 2017 at 5:20 PM, A.S. Dong <aisheng.dong@nxp.com> wrote:
>> > How about you send a separate baud algorithm improvement patch later?
>>
>> Why not to do it right a way?
>>
>
> Because I thought that could be a separate patch which is doing algorithm
> improvement, then we can have the full history and a clear comparison.
>
> And also we are still not sure whether it works, we don't want to block on it
> too long.
>
> But if you're pretty sure about it, I would wait for some more time.
>
> However, personally I would still rather keep them in two separate Patches
> for clearer history and comparison.

Since we already near to -rc5, I would rather agree with you.
So, please proceed with your approach and we can modify it in relaxing
mode later on.

Thanks, and sorry for the delay!

-- 
With Best Regards,
Andy Shevchenko

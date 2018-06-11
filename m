From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH v2 07/24] serdev: Allows dynamic creation of devices via sysfs
Date: Mon, 11 Jun 2018 15:03:10 +0200
Message-ID: <CAPybu_1CLnKDyxkRvrx0Ha=f3XK-ktNUsSTJeMRUurZ1ztHotw@mail.gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-8-ricardo.ribalda@gmail.com> <CAHp75Vf-V7BVU_SiyBp18D0cM_nOO=EAxfgzUaa4-hngh9PeMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vf-V7BVU_SiyBp18D0cM_nOO=EAxfgzUaa4-hngh9PeMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

I cannot use strstrip() because the buffer is const. But I have
replaced strncpy with strscpy.

Thanks!

-- 
Ricardo Ribalda

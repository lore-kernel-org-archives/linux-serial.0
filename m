From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 04/19] Bluetooth: hci_nokia: Add serdev_id_table
Date: Tue, 5 Jun 2018 16:36:08 +0300
Message-ID: <CAHp75VfTkRiwioxg-65wgX9q9cpFQPWj3GqUZc-VobNwPUs2tA@mail.gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com> <20180529131014.18641-5-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529131014.18641-5-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 29, 2018 at 4:09 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Describe which hardware is supported by the current driver.

> +static struct serdev_device_id nokia_bluetooth_serdev_id[] = {
> +       { "hp4-bluetooth", },

> +       {},

Terminator line better w/o comma.

> +};



-- 
With Best Regards,
Andy Shevchenko

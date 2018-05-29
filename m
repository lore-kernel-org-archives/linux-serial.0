From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 07/19] serdev: Allows dynamic creation of devices via sysfs
Date: Tue, 29 May 2018 10:38:09 -0500
Message-ID: <CAL_JsqKRqKJmPc-QQBcN9j5=_y+MH+Rn1aZNun=MAgBMpvDL2w@mail.gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com> <20180529131014.18641-8-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529131014.18641-8-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Tue, May 29, 2018 at 8:10 AM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Allow creating and deleting devices via sysfs. Devices created will be
> matched to serdev drivers via modalias (the string provided by the user)
> and deleted via their name. Eg:
>
>  # Create device
> root@qt5022:~# echo ttydev > /sys/bus/serial/devices/serial0/new_device
>
>  # Delete device
> root@qt5022:~#
>         echo serial0-0 > /sys/bus/serial/devices/serial0/delete_device

I think the model here should be the kernel provides dummy slave
device for each serial port and then you can use bind and unbind to
bind to a particular driver.

Rob

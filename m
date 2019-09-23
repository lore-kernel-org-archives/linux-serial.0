From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
Date: Mon, 23 Sep 2019 21:31:22 +0200
Message-ID: <91a3e827-0ab7-3bd9-5d65-bd5cae2c367c@gmail.com>
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
 <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
 <4c2cc8b7-8541-0912-3162-399777dc8dd2@gmail.com>
 <8bed7cde-1f59-c5bf-9506-757dd89ad594@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8bed7cde-1f59-c5bf-9506-757dd89ad594@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 9/23/19 10:14 AM, Hans de Goede wrote:
> Ack, this is what drivers/i2c/i2c-core-acpi.c is doing and more in general
> all ACPI enumeration code always first checks _STA before doing anything
> else, so I think it would be best to do this here too.
> 
> Actually I think it might be best to fully copy how drivers/i2c/i2c-core-acpi.c
> does things.

Right, I will do that then.

Thanks,

Maximilian

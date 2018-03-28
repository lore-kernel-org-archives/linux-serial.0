From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Remove DMI quirk for the MINIX Z83-4
Date: Wed, 28 Mar 2018 11:39:29 +0200
Message-ID: <5DF0FA92-1058-45C9-AB5E-6C9678EF6BAE@holtmann.org>
References: <20180326220928.2755-1-ianwmorrison@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180326220928.2755-1-ianwmorrison@gmail.com>
Sender: stable-owner@vger.kernel.org
To: ianwmorrison@gmail.com
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>, stable@vger.kernel.org, hdegoede@redhat.com
List-Id: linux-serial@vger.kernel.org

Hi Ian,

> As Interrupt resource specified IRQs are now assumed to be always
> active-low the DMI quirk for the MINIX Z83-4 is no longer required.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
> ---
> drivers/bluetooth/hci_bcm.c | 7 -------
> 1 file changed, 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

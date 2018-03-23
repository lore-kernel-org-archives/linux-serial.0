From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/5] Bluetooth: hci_bcm: Add irq_polarity module option
Date: Fri, 23 Mar 2018 21:51:38 +0100
Message-ID: <5F42B415-8930-4F06-AB97-7E724B9ECDE6@holtmann.org>
References: <20180316202811.5678-1-hdegoede@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180316202811.5678-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Hans,

> Add irq_polarity module option for easier troubleshooting of irq-polarity
> issues.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_bcm.c | 20 +++++++++++++++-----
> 1 file changed, 15 insertions(+), 5 deletions(-)

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel

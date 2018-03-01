From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: btusb: Remove Yoga 920 from the
 btusb_needs_reset_resume_table
Date: Thu, 1 Mar 2018 08:43:35 +0100
Message-ID: <2F0ACD89-F225-479A-A65E-2F84E60781D3@holtmann.org>
References: <20180228105750.6491-1-hdegoede@redhat.com>
 <20180228105750.6491-2-hdegoede@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180228105750.6491-2-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, stable <stable@vger.kernel.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-serial@vger.kernel.org

Hi Hans,

> Commit 55a9c95d70ab ("Bluetooth: btusb: Use DMI matching for QCA
> reset_resume quirking"), added the Lenovo Yoga 920 to the
> btusb_needs_reset_resume_table.
> 
> Testing has shown that this is a false positive and the problems where
> caused by issues with the initial fix: commit fd865802c66b ("Bluetooth:
> btusb: fix QCA Rome suspend/resume"), which has already been reverted.
> 
> So the QCA Rome BT in the Yoga 920 does not need a reset-resume quirk at
> all and this commit removes it from the btusb_needs_reset_resume_table.
> 
> Note that after this commit the btusb_needs_reset_resume_table is now
> empty. It is kept around on purpose, since this whole series of commits
> started for a reason and there are actually broken platforms around,
> which need to be added to it.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> Fixes: 55a9c95d70ab ("Bluetooth: btusb: Use DMI matching for QCA ...")
> Cc: stable@vger.kernel.org
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Kevin Fenzi <kevin@scrye.com>
> Suggested-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/btusb.c | 7 -------
> 1 file changed, 7 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

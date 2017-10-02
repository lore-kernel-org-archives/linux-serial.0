From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/9] Bluetooth: hci_bcm: Add (runtime)pm support to the serdev drv
Date: Mon,  2 Oct 2017 17:23:47 +0200
Message-ID: <20171002152356.4714-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi All,

The ACPI subsys is going to move over to instantiating ACPI enumerated
HCIs as serdevs, rather then as platform devices.

This means that the serdev driver paths of hci_bcm.c also need to start
supporting (runtime)pm through GPIOs and a host-wake IRQ.

This series makes most of the code in hci_bcm.c indepdenent from how
the hci was instantiated and then more or less unifies the platform
and serdev drivers, adding (runtime)pm / GPIO / IRQ support to the
serdev driver.

Besides adding (runtime)pm support, GPIO control in general is necessary
to e.g. keep the ACPI BCM2E7E id used with the BCM4356A2 wifi/bt combo
on the GPD pocket working after moving over to serdev enumeration.

I've chosen to keep the platform enumeration based code paths in place
for now. This way we can first merge this series and then, once this
series is in place, the first 2 patches of Frédéric Danis RFC series
for ACPI serdev support can be merged without causing any regressions.

Once the ACPI serdev support is merged a follow up patch removing the
platform-device related code can be submitted.

Note the 2nd patch in this series is a resend of a bug-fix I submitted
a couple of days ago, I've included that with the series to avoid
conflicts when applying the series without that fix.

Regards,

Hans

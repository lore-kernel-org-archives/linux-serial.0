From: Sven Brauch <mail@svenbrauch.de>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Wed, 22 Jul 2015 02:47:01 +0200
Message-ID: <55AEE805.9050204@svenbrauch.de>
References: <55AC1883.4050605@svenbrauch.de>
 <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de>
 <1437486195.3823.13.camel@suse.com> <55AEBD06.6020402@svenbrauch.de>
 <55AED708.903@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R8U9bJb3UPg69PLtFUvK3vHVmKui79eXG"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AED708.903@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Oliver Neukum <oneukum@suse.com>, Johan Hovold <johan@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Toby Gray <toby.gray@realvnc.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R8U9bJb3UPg69PLtFUvK3vHVmKui79eXG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey,

On 22/07/15 01:34, Peter Hurley wrote:
> I'd like to see that data, if you can, which will help me understand
> at least the timing.
Sure, please see below for the code which produced the output
and the actual output. Let me know if you need anything else.
This was run with the unmodified version of the driver, i.e. without
my patch.

Sven
------

Code which produced the output:

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 5c8f581..3d26c87 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -404,12 +404,16 @@ static int acm_submit_read_urbs(struct acm *acm, gf=
p_t mem_flags)
=20
 static void acm_process_read_urb(struct acm *acm, struct urb *urb)
 {
+    int written;
+
        if (!urb->actual_length)
                return;
=20
-       tty_insert_flip_string(&acm->port, urb->transfer_buffer,
+       written =3D tty_insert_flip_string(&acm->port, urb->transfer_buff=
er,
                        urb->actual_length);
        tty_flip_buffer_push(&acm->port);
+    printk("cdc-acm: acm_process_read_urb: processed %d of %d (free spac=
e left: %d)\n",
+           written, urb->actual_length, tty_buffer_space_avail(&acm->por=
t));
 }
=20
 static void acm_read_bulk_callback(struct urb *urb)
@@ -448,6 +452,9 @@ static void acm_read_bulk_callback(struct urb *urb)
        /* throttle device if requested by tty */
        spin_lock_irqsave(&acm->read_lock, flags);
        acm->throttled =3D acm->throttle_req;
+    if (acm->throttle_req) {
+        printk("cdc-acm: acm_read_bulk_callback: throttle requested\n");=

+    }
        if (!acm->throttled) {
                spin_unlock_irqrestore(&acm->read_lock, flags);
                acm_submit_read_urb(acm, rb->index, GFP_ATOMIC);
@@ -758,6 +765,9 @@ static void acm_tty_throttle(struct tty_struct *tty)
 {
        struct acm *acm =3D tty->driver_data;
=20
+    printk("cdc-acm: acm_tty_throttle: called; free space in tty: %d\n",=

+           tty_buffer_space_avail(&acm->port));
+
        spin_lock_irq(&acm->read_lock);
        acm->throttle_req =3D 1;
        spin_unlock_irq(&acm->read_lock);
@@ -768,6 +778,9 @@ static void acm_tty_unthrottle(struct tty_struct *tty=
)
        struct acm *acm =3D tty->driver_data;
        unsigned int was_throttled;
=20
+    printk("cdc-acm: acm_tty_unthrottle: called; free space in tty: %d\n=
",
+           tty_buffer_space_avail(&acm->port));
+
        spin_lock_irq(&acm->read_lock);
        was_throttled =3D acm->throttled;
        acm->throttled =3D 0;

______________________________
Output from dmesg (cut a bit in the beginning):

[...]
[62517.602478] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63232)
[62517.602480] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63232)
[62517.602483] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62208)
[62517.602485] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62208)
[62517.602487] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61184)
[62517.602489] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61184)
[62517.602494] cdc-acm: acm_tty_throttle: called; free space in tty: 6348=
8
[62517.602600] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.602602] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.602603] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.602604] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.602606] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61440)
[62517.602607] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.602609] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61440)
[62517.602610] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.602612] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 60416)
[62517.602613] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.602726] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.602727] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.602729] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.602730] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.602731] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.602732] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.602734] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61440)
[62517.602735] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.602737] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61440)
[62517.602738] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.602959] cdc-acm: acm_tty_unthrottle: called; free space in tty: 64=
512
[62517.603852] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 64256)
[62517.603856] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63232)
[62517.603858] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63232)
[62517.603976] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.603979] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.603981] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.603983] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.603985] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61440)
[62517.603991] cdc-acm: acm_tty_throttle: called; free space in tty: 6348=
8
[62517.604101] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 64512)
[62517.604103] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.604105] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.604105] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.604107] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.604108] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.604110] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.604111] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.604113] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.604115] cdc-acm: acm_tty_unthrottle: called; free space in tty: 62=
464
[62517.604121] cdc-acm: acm_tty_throttle: called; free space in tty: 6451=
2
[62517.604227] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.604228] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.604230] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.604231] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.604233] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.604234] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.604235] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.604236] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.604375] cdc-acm: acm_tty_unthrottle: called; free space in tty: 64=
512
[62517.605355] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 64256)
[62517.605358] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63232)
[62517.605360] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63232)
[62517.605362] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62208)
[62517.605364] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62208)
[62517.605371] cdc-acm: acm_tty_throttle: called; free space in tty: 6451=
2
[62517.605478] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.605479] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.605481] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.605482] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.605484] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.605485] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.605487] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.605488] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.605490] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61440)
[62517.605491] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.605602] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.605603] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.605605] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.605606] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.605608] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.605609] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.605610] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61440)
[62517.605611] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.605613] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61440)
[62517.605614] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.605726] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.605728] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.605729] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.605730] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.605891] cdc-acm: acm_tty_unthrottle: called; free space in tty: 64=
512
[62517.606858] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 64256)
[62517.606862] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63232)
[62517.606864] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63232)
[62517.606866] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62208)
[62517.606868] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62208)
[62517.606871] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61184)
[62517.606873] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61184)
[62517.606881] cdc-acm: acm_tty_throttle: called; free space in tty: 6348=
8
[62517.606978] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.606980] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.606982] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.606983] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.606985] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61440)
[62517.606986] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.606987] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61440)
[62517.606988] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.606990] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 60416)
[62517.606991] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.607102] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.607104] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.607106] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61440)
[62517.607107] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.607108] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61440)
[62517.607109] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.607111] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 60416)
[62517.607112] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.607114] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 60416)
[62517.607115] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.607414] cdc-acm: acm_tty_unthrottle: called; free space in tty: 64=
512
[62517.608229] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 64256)
[62517.608232] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63232)
[62517.608234] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63232)
[62517.608236] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62208)
[62517.608353] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 64512)
[62517.608356] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.608358] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.608361] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.608363] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.608401] cdc-acm: acm_tty_throttle: called; free space in tty: 6451=
2
[62517.608480] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.608481] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.608483] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.608484] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.608485] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.608486] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.608488] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62464)
[62517.608489] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.608491] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61440)
[62517.608492] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.608603] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 64512)
[62517.608604] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.608606] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.608607] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.608609] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63488)
[62517.608610] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.608691] cdc-acm: acm_tty_unthrottle: called; free space in tty: 64=
512
[62517.609738] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 64256)
[62517.609743] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63232)
[62517.609747] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 63232)
[62517.609750] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62208)
[62517.609754] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 62208)
[62517.609757] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61184)
[62517.609855] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 61184)
[62517.609859] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 60160)
[62517.609862] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 60160)
[62517.609866] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 59136)
[62517.610023] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 59136)
[62517.610030] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 58112)
[62517.610035] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 58112)
[62517.610040] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 57088)
[62517.610106] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 57088)
[62517.610110] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 56064)
[62517.610113] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 56064)
[62517.611115] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 55808)
[62517.611119] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 54784)
[62517.611231] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 54784)
[62517.611236] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 53760)
[62517.611240] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 53760)
[62517.611243] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 52736)
[62517.611247] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 52736)
[62517.611386] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 51712)
[62517.611391] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 51712)
[62517.611396] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 50688)
[62517.611401] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 50688)
[62517.611406] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 49664)
[62517.611482] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 49664)
[62517.611489] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 48640)
[62517.611493] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 48640)
[62517.611606] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 47616)
[62517.611609] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 47616)
[62517.612610] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 47360)
[62517.612615] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 46336)
[62517.612618] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 46336)
[62517.612622] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 45312)
[62517.612734] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 45312)
[62517.612738] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 44288)
[62517.612741] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 44288)
[62517.612745] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 43264)
[62517.612859] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 43264)
[62517.612862] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 42240)
[62517.612866] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 42240)
[62517.612869] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 41216)
[62517.612981] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 41216)
[62517.612984] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 40192)
[62517.612987] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 40192)
[62517.612991] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 39168)
[62517.613106] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 39168)
[62517.614111] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 38912)
[62517.614116] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 37888)
[62517.614119] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 37888)
[62517.614124] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 36864)
[62517.614127] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 36864)
[62517.614130] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 35840)
[62517.614232] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 35840)
[62517.614235] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 34816)
[62517.614239] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 34816)
[62517.614247] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 33792)
[62517.614359] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 33792)
[62517.614363] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 32768)
[62517.614366] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 32768)
[62517.614369] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 31744)
[62517.614483] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 31744)
[62517.614486] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 30720)
[62517.614489] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 30720)
[62517.615485] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 30464)
[62517.615489] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 29440)
[62517.615492] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 29440)
[62517.615611] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 28416)
[62517.615614] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 28416)
[62517.615617] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 27392)
[62517.615734] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 27392)
[62517.615737] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 26368)
[62517.615741] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 26368)
[62517.615746] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 25344)
[62517.615749] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 25344)
[62517.615858] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 24320)
[62517.615861] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 24320)
[62517.615864] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 23296)
[62517.615867] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 23296)
[62517.615983] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 22272)
[62517.615986] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 22272)
[62517.616989] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 22016)
[62517.616994] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 20992)
[62517.616997] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 20992)
[62517.617001] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 19968)
[62517.617110] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 19968)
[62517.617114] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 18944)
[62517.617117] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 18944)
[62517.617120] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 17920)
[62517.617233] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 17920)
[62517.617240] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 16896)
[62517.617243] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 16896)
[62517.617246] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 15872)
[62517.617362] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 15872)
[62517.617366] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 14848)
[62517.617369] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 14848)
[62517.617372] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 13824)
[62517.617484] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 13824)
[62517.618487] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 13568)
[62517.618491] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 12544)
[62517.618494] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 12544)
[62517.618498] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 11520)
[62517.618501] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 11520)
[62517.618504] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 10496)
[62517.618507] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 10496)
[62517.618613] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 9472)
[62517.618616] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 9472)
[62517.618621] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 8448)
[62517.618625] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 8448)
[62517.618737] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 7424)
[62517.618740] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 7424)
[62517.618744] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 6400)
[62517.618747] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 6400)
[62517.618859] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 5376)
[62517.618862] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 5376)
[62517.619863] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 5120)
[62517.619867] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 4096)
[62517.619870] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 4096)
[62517.619874] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 3072)
[62517.620022] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 3072)
[62517.620028] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 2048)
[62517.620033] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 2048)
[62517.620037] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 1024)
[62517.620113] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 2048)
[62517.620118] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 1024)
[62517.620121] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 1024)
[62517.620126] cdc-acm: acm_tty_throttle: called; free space in tty: 2304=

[62517.620245] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 2304)
[62517.620247] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.620250] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 2304)
[62517.620251] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.620253] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 1280)
[62517.620255] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.620257] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 1280)
[62517.620258] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.620264] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 256)
[62517.620265] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.620267] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 256)
[62517.620269] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.620318] cdc-acm: acm_tty_unthrottle: called; free space in tty: 25=
6
[62517.621367] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 0)
[62517.621372] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 0)
[62517.621375] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 0)
                  ------- FAILURE HAPPENS HERE --------
[62517.621378] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.621381] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.621489] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.621492] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.621495] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.621618] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.621622] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.621626] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.621744] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.621747] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.621750] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.621862] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.621865] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.621867] cdc-acm: acm_process_read_urb: processed 0 of 1024 (free s=
pace left: 0)
[62517.622357] cdc-acm: acm_tty_throttle: called; free space in tty: 1024=

[62517.622746] cdc-acm: acm_process_read_urb: processed 16 of 16 (free sp=
ace left: 6144)
[62517.622748] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.622750] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 5120)
[62517.622751] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.622753] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 5120)
[62517.622754] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.622863] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 4096)
[62517.622864] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.622866] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 4096)
[62517.622867] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.622869] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 3072)
[62517.622870] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.622872] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 3072)
[62517.622873] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.622875] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 2048)
[62517.622876] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.622989] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 4096)
[62517.622991] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.622993] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 3072)
[62517.622994] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.622996] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 3072)
[62517.622997] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.622999] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 2048)
[62517.623000] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.623002] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 2048)
[62517.623003] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.623116] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 3072)
[62517.623118] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.623119] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 3072)
[62517.623120] cdc-acm: acm_read_bulk_callback: throttle requested
[62517.623122] cdc-acm: acm_process_read_urb: processed 1024 of 1024 (fre=
e space left: 2048)
[62517.623123] cdc-acm: acm_read_bulk_callback: throttle requested


--R8U9bJb3UPg69PLtFUvK3vHVmKui79eXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVrugJAAoJEGjKjjjEuz9LTkIP/1fFn0AC8/ljwUchsj9DVQKR
ajU4jdOzL89WLSHDSB49cqZFPRx+9h6ktrpKHnDDoK1hIsl2B1e6GCCg8lmZbgN8
sUgXk+k9/XnlDhZo88mgZsjKCqkEOj5wrp/LsqdkzOnoRVHkOGrzMGeqLMWbOVTT
yR09zKRX2rZwLIiLAiy1mqQV4732U4LKlsvPC3fTvzvTvDR25x+kvW8C44uF58+B
BGYgxtptUTzieZkXo1NXq0tc7g/Y1HYAQP0cMmAHrLbloL5DFUvlAb7+Vw2IY0F5
CJWFLB+70SFvCXhlCZ39qIgfKcTZ4j8iX8RWxmQdg6rlakb8j8BJGTvH8RsjVqwA
wXM1tuj5yF3ZecSkf5Uh9ovVRbzwqXdv67fVhwRQmqsc0ypACAvY0YVRRJNuP5bh
T1ZvP/mfkLy5h3/L2TEDJyKSns47LnVmxJ18dZd17yi62G2Fp7mqBHcWDa71iLHW
hZUfcvMEueXL2LBu5kN4/g5cxavFoiV19smRVZ6n8RahbRxcsG62GyVtnKTpkQu5
KTlqmFrHudCagtMW9LahXOl1TzHeqCq5FHOelAHnSB5jmaUqtph2WL3i0K87PVR7
IqTqUHZib2Q0UcyKSNIVnvL8tMGUHMiakiiN8LDuwC/Kz9wBd3nmI+1FtyT4Kd7X
Bv2/3Whqv110AYXZS4ov
=Yf6x
-----END PGP SIGNATURE-----

--R8U9bJb3UPg69PLtFUvK3vHVmKui79eXG--

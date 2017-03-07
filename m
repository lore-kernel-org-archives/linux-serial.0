From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/10] serdev: add serdev_device_set_rts
Date: Tue, 7 Mar 2017 10:07:56 -0600
Message-ID: <CAL_Jsq+N3GU2Dry2uMaF+zxE6+d2aGmfZui-J2MGOWAUJNoH5w@mail.gmail.com>
References: <20170304115833.3538-1-sre@kernel.org> <20170304115833.3538-10-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170304115833.3538-10-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Mar 4, 2017 at 5:58 AM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Add function to enable/disable RTS line.
>
> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---

> +static void ttyport_set_rts(struct serdev_controller *ctrl, bool enable)
> +{
> +       struct serport *serport = serdev_controller_get_drvdata(ctrl);
> +       struct tty_struct *tty = serport->tty;
> +       int status = tty->driver->ops->tiocmget(tty);
> +       unsigned int set = 0;
> +       unsigned int clear = 0;
> +
> +       if (enable) {
> +               set |= (TIOCM_OUT2 | TIOCM_RTS);
> +               clear = ~set;
> +               set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> +                      TIOCM_OUT2 | TIOCM_LOOP;
> +               clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> +                        TIOCM_OUT2 | TIOCM_LOOP;
> +               status = tty->driver->ops->tiocmset(tty, set, clear);
> +       } else {
> +               set &= ~(TIOCM_OUT2 | TIOCM_RTS);
> +               clear = ~set;
> +               set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> +                      TIOCM_OUT2 | TIOCM_LOOP;
> +               clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> +                        TIOCM_OUT2 | TIOCM_LOOP;
> +               status = tty->driver->ops->tiocmset(tty, set, clear);

The logic here can be greatly simplified. Here's a patch to the
original version that I came up with, but haven't tested:

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index de20a438a78a..0e35663c5d04 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -264,8 +264,8 @@ void hci_uart_set_flow_control(struct hci_uart
*hu, bool enable)
        struct tty_struct *tty = hu->tty;
        struct ktermios ktermios;
        int status;
-       unsigned int set = 0;
-       unsigned int clear = 0;
+       unsigned int set;
+       unsigned int clear = TIOCM_DTR | TIOCM_OUT1 | TIOCM_LOOP;

        if (enable) {
                /* Disable hardware flow control */
@@ -280,25 +280,15 @@ void hci_uart_set_flow_control(struct hci_uart
*hu, bool enable)
                status = tty->driver->ops->tiocmget(tty);
                BT_DBG("Current tiocm 0x%x", status);

-               set &= ~(TIOCM_OUT2 | TIOCM_RTS);
-               clear = ~set;
-               set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
-                      TIOCM_OUT2 | TIOCM_LOOP;
-               clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
-                        TIOCM_OUT2 | TIOCM_LOOP;
-               status = tty->driver->ops->tiocmset(tty, set, clear);
+               clear |= TIOCM_RTS | TIOCM_OUT2;
+               status = tty->driver->ops->tiocmset(tty, 0, clear);
                BT_DBG("Clearing RTS: %s", status ? "failed" : "success");
        } else {
                /* Set RTS to allow the device to send again */
                status = tty->driver->ops->tiocmget(tty);
                BT_DBG("Current tiocm 0x%x", status);

-               set |= (TIOCM_OUT2 | TIOCM_RTS);
-               clear = ~set;
-               set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
-                      TIOCM_OUT2 | TIOCM_LOOP;
-               clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
-                        TIOCM_OUT2 | TIOCM_LOOP;
+               set = TIOCM_OUT2 | TIOCM_RTS;
                status = tty->driver->ops->tiocmset(tty, set, clear);
                BT_DBG("Setting RTS: %s", status ? "failed" : "success");

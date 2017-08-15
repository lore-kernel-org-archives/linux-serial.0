From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [patch v3 1/3] drivers: jtag: Add JTAG core driver
Date: Tue, 15 Aug 2017 13:16:06 +0200
Message-ID: <CAK8P3a3DutrfhGrd9MnDFbzhfvnZXSyrV2RbTgrFGgpbAs=H0w@mail.gmail.com>
References: <1502791207-26951-1-git-send-email-oleksandrs@mellanox.com> <1502791207-26951-2-git-send-email-oleksandrs@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502791207-26951-2-git-send-email-oleksandrs-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oleksandr Shamray <oleksandrs-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Cc: gregkh <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mec-WqBc5aa1uDFeoWH0uzbU5w@public.gmane.org, vadimp-45czdsxZ+A5DPfheJLI6IQ@public.gmane.org, system-sw-low-level-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, openocd-devel-owner-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Jiri Pirko <jiri-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 15, 2017 at 12:00 PM, Oleksandr Shamray
<oleksandrs-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org> wrote:

> +       case JTAG_IOCXFER:
> +               if (copy_from_user(&xfer, varg, sizeof(struct jtag_xfer)))
> +                       return -EFAULT;
> +
> +               if (xfer.length >= JTAG_MAX_XFER_DATA_LEN)
> +                       return -EFAULT;
> +
> +               user_tdio_data = xfer.tdio;
> +               xfer.tdio = jtag_copy_from_user((void __user *)user_tdio_data,
> +                                               xfer.length);
> +               if (!xfer.tdio)
> +                       return -ENOMEM;

This is not safe for 32-bit processes on 64-bit kernels, since the
structure layout differs for the pointer member. It's better to always
use either rework the structure to avoid the pointer, or to use a
__u64 member to store it, and then use u64_to_user_ptr()
to convert it in the kernel.

> +       case JTAG_GIOCSTATUS:
> +               if (jtag->ops->status_get)
> +                       err = jtag->ops->status_get(jtag,
> +                                               (enum jtag_endstate *)&value);

This pointer cast is also not safe, as an enum might have a different
size than the 'value' variable that is not an enum. I think you need to
change the argument type for the callback, or maybe use another
intermediate.

> +static int jtag_open(struct inode *inode, struct file *file)
> +{
> +       struct jtag *jtag = container_of(inode->i_cdev, struct jtag, cdev);
> +
> +       spin_lock(&jtag->lock);
> +
> +       if (jtag->is_open) {
> +               dev_info(NULL, "jtag already opened\n");
> +               spin_unlock(&jtag->lock);
> +               return -EBUSY;
> +       }
> +
> +       jtag->is_open = true;
> +       file->private_data = jtag;
> +       spin_unlock(&jtag->lock);
> +       return 0;
> +}

Does the 'is_open' flag protect you from something that doesn't
also happen after a 'dup()' call on the file descriptor?

> + * @mode: access mode
> + * @type: transfer type
> + * @direction: xfer direction
> + * @length: xfer bits len
> + * @tdio : xfer data array
> + * @endir: xfer end state
> + *
> + * Structure represents interface to Aspeed JTAG device for jtag sdr xfer
> + * execution.
> + */
> +struct jtag_xfer {
> +       __u8    mode;
> +       __u8    type;
> +       __u8    direction;
> +       __u32   length;
> +       __u8    *tdio;
> +       __u8    endstate;
> +};

As mentioned above, the pointer in here makes it incompatible. Also,
you should reorder the members to avoid the implied padding.
Moving the 'endstate' before 'length' is sufficient.

        Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

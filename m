From: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 00/15] MIPS Malta DT Conversion
Date: Mon, 25 May 2015 02:59:31 -0500
Message-ID: <CAOS_Y6TRN2b5PGxWdO6SD5W2Wmo33Z88DeHw7Jrxw4TzzVYLcA@mail.gmail.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Leonid Yegoshin <Leonid.Yegoshin-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, "Steven J. Hill" <Steven.Hill-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Qais Yousef <qais.yousef-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Markos Chandras <markos.chandras-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Michal Marek <mm>
List-Id: linux-serial@vger.kernel.org

On Fri, May 22, 2015 at 10:50 AM, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> wrote:
> This series begins converting the MIPS Malta board to use device tree,
> which is done with a few goals in mind:
>
>   - To modernise the Malta board support, providing a cleaner example to
>     people referencing it when bringing up new boards and reducing the
>     amount of code they need to write.
>
>   - To make the code at the board level more generic with the eventual
>     aim of sharing it between multiple boards & allowing for
>     multi-platform kernel binaries. Although this series doesn't result
>     in the kernel reaching those goals, it is a step in that direction.
>
>   - To result in a more maintainable kernel through a combination of the
>     above.

How would I go about testing this under qemu?

(Especially the "more than 256 megs ram" part. :)

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

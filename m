From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH RFC] omap-serial: make serial_omap_restore_context depend
 on CONFIG_PM_RUNTIME
Date: Thu, 12 Jan 2012 13:02:27 +0530
Message-ID: <CAAL8m4x5wf_XtPSe=GEG9tokrZmbVy4j5rbuwmoLYBuiVaWMWg@mail.gmail.com>
References: <1326261400-3929-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63895 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab2ALHcs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jan 2012 02:32:48 -0500
In-Reply-To: <1326261400-3929-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 11, 2012 at 11:26 AM, Shubhrajyoti D <shubhrajyoti@ti.com> =
wrote:
> The function serial_omap_restore_context is called only from
> serial_omap_runtime_resume which depends on CONFIG_PM_RUNTIME. Make
> serial_omap_restore_context also compile conditionally.
>
> if CONFIG_PM_RUNTIME is not defined below warn may be seen.
>
> =A0LD =A0 =A0 =A0net/xfrm/built-in.o
> drivers/tty/serial/omap-serial.c:1524: warning: 'serial_omap_restore_=
context' defined but not used
> =A0CC =A0 =A0 =A0drivers/tty/vt/selection.o
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Acked-by: Govindraj.R <govindraj.raja@ti.com>

> ---
> applies on Tony's uart branch
>

Should apply on cleanly on mainline also
Please check.

Same comments for other patch (omap-serial :Make the
suspend/resume functions depend on CONFIG_PM_SLEEP)

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

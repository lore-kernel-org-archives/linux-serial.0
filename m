From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] qcserial: don't enable autosuspend
Date: Thu, 2 Feb 2012 09:40:11 +0100
Message-ID: <201202020940.11910.oliver@neukum.org>
References: <20120201210745.GD16802@google.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120201210745.GD16802-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Tuttle <ttuttle-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Am Mittwoch, 1. Februar 2012, 22:07:45 schrieb Thomas Tuttle:
> We've found that qcserial devices will not always wake up reliably
> from autosuspend, so disable it.

This might quite hurt power consumption. Can you also solve this
with the RESET_RESUME quirk?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82815485949;
	Mon, 28 Sep 2026 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586431; cv=none; b=S2XBqNtg/UN6vqPVmnKLjNIoVyAT02EVZxmWoILNlOqk0AtOyW2BTHg0OWWjZG54jebEsFWIjkFLmgQUemg84wr2pLyI2al+6JIxw/2fz81vkQNIgZ9CGtr67LAJBLxbcp48jfUXldBwAIEvkJFlolVqkux2vOuzk3RK4JgJPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586431; c=relaxed/simple;
	bh=dAtvLrjUvMJgdZTQ8XVAIxOGXDZkRD/ZGR7CSApiYA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c4K1H7PkMJZX3NB+JIHO9iH+Wkj/+2r6v3PGdSFhfSDX0v19k3LaUiarPqRAIlgV1m0YW2p5cEwRLFbXm/9M78oTFVvyF5bJbSYHJzNtVclD2ZfaSSXlJ71/7V+jW5uWcnGgnMJC1e8ptR+ILao9pl3UiF+tppAzqYXPb2re8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClUGi41R; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClUGi41R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586429; x=1822122429;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dAtvLrjUvMJgdZTQ8XVAIxOGXDZkRD/ZGR7CSApiYA0=;
  b=ClUGi41RKRvypTrjEiiJYhhVBaAHovO0CnPKB0rOtRG4i4d0zN78hdKt
   kWa4S93oHan4u6a6kn9efEhd4mFf6DFQhHuzclyM5GeXxFq50SooFgCcd
   VcCazxSdEpKz5A4kdx6sQQgOL59dpp/Hz90k3PPnm5lPDAmn1T5sIuAuE
   JXV91+/wR53XI8SWna+BkEQZcXdyFOqx9/KYfyfEduV9XYB3QPWevhM8S
   1i2+mr+iQKGOirUpIFuKahXEjiSZXYkbu2lgPfUauGePcroEBQgh8gZyO
   sbJ3zUtoMhxqiHsxpBOoYok+NjjBQZkTzljBkZeyRsMBAld/wIf9HNZJx
   A==;
X-CSE-ConnectionGUID: vnFuWbsiTMiULDdkkEzmlA==
X-CSE-MsgGUID: gF+a4JEORHeMJ9bNM7P5/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="113064571"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="113064571"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:07:08 -0700
X-CSE-ConnectionGUID: ZUeIqnn/S/qrXMCSWW+wHQ==
X-CSE-MsgGUID: Dz6IRCGHRNWA+R3MTY6kTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278351074"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:07:05 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, simona@ffwll.ch
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-serial@vger.kernel.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 1/5] vt: Add cursor-size helpers
In-Reply-To: <20260928085724.41660-2-tzimmermann@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260928085724.41660-1-tzimmermann@suse.de>
 <20260928085724.41660-2-tzimmermann@suse.de>
Date: Mon, 28 Sep 2026 12:07:02 +0300
Message-ID: <7e3cccd612e87e6e85271a026d9fc737a56eaa6c@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 28 Sep 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Cursors in the VT subsystem are blocks within a character cell that are
> filled with the foreground color. The new helpers vc_cursor_start() and
> vc_cursor_end() return the scanlines in which the cursor block starts rsp.
> ends. This is compatible with VGA hardware.
>
> In terms of cursor design, the new cursor-size helpers follow established
> styles in fbcon. The only exception is in underline cursors for fonts with
> a size larger than 10. The underlining dash is now one pixel closer to
> the font-glyph data, so that the cursor looks less detached. This follows
> the style used by vgacon.
>
> Users control the cursor size with the vt module's parameter cur_default
> or with the ESC sequence \e[?Nc, where N is the cursor-size constant. In
> case of an invalid setting, the new helpers fall back to cur_default and
> then underline cursors; in this order.
>
> Similar code in vgacon and fbcon ignores the cursor's default size stored
> in vt.cur_default. The consoles default to full-block cursors, while vt
> defaults to underline cursors. VGA BIOSes also tend to use underline by.
> default. Upon initialization vt applies its default to the console, but
> each console might fall back to it own default. For example, running the
> ESC code from above with the invalid constant of 8 magically flips the
> cursor from underline to block size on vgacon. Another call with N set
> to 0 (i.e., default) magically flips it back to underlyine. Making
> underline the new default everywhere harmonizes vt, fbcon and most VGA
> BIOSes.
>
> v3:
> - mention user interfaces to control cursor size in commit message (GregKH)
> - elaborate defaults (GregKH)
> - move retry logic into helper
> - handle CUR_DEF
> v2:
> - export non-font interface for vgacon
> - avoid interference from concurrent user space (Sashiko)
> - fix function docs (Sashiko)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Helge Deller <deller@gmx.de>
> ---
>  drivers/tty/vt/vt.c            | 104 +++++++++++++++++++++++++++++++++
>  include/linux/console_struct.h |   7 +++
>  2 files changed, 111 insertions(+)
>
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 57edf37495a8..8141296ccad0 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -71,6 +71,7 @@
>   * by Adam Tla/lka <atlka@pg.gda.pl>, Aug 2006
>   */
>  
> +#include <linux/compiler.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/sched/signal.h>
> @@ -264,6 +265,109 @@ unsigned int vc_font_size(const struct vc_font *font)
>  }
>  EXPORT_SYMBOL_GPL(vc_font_size);
>  
> +/*
> + * Cursors
> + */
> +
> +static unsigned int vc_cursor_size(unsigned int cursor_size)
> +{
> +	const unsigned int cursor_default_size = CUR_SIZE(READ_ONCE(cur_default));
> +
> +retry:
> +	switch (cursor_size) {
> +	case CUR_NONE:
> +	case CUR_UNDERLINE:
> +	case CUR_LOWER_THIRD:
> +	case CUR_LOWER_HALF:
> +	case CUR_TWO_THIRDS:
> +	case CUR_BLOCK:
> +		return cursor_size;
> +	default:
> +		pr_warn_once("Unknown cursor %u\n", cursor_size);
> +		fallthrough;
> +	case CUR_DEF:
> +		/*
> +		 * Use user-given default size, or underline if
> +		 * the given default is invalid.
> +		 */
> +		if (cursor_size != cursor_default_size)
> +			cursor_size = cursor_default_size;
> +		else
> +			cursor_size = CUR_UNDERLINE;
> +		goto retry;

Complete bikeshed, but IMO goto for retries is ugly. It's fine for error
handling, but this could trivially be a loop.

BR,
Jani.

> +	}
> +}
> +
> +/**
> + * vc_cursor_start - Calculates the cursor's first scanline within a character cell
> + * @cell_height: The overall height of the character cell
> + * @cursor_size: The size constant of cursor pattern
> + *
> + * The parameter @cell_height is the height of the character cell as
> + * displayed by the console. The argument given in @cursor_size is one
> + * of the CUR_ constants, as stored in struct @vc_data.vc_cursor_type.
> + * For unknown values, the helper draws the default cursor or an underline
> + * dash.
> + *
> + * Returns:
> + * The index of the cursor's first scanline within the character cell
> + */
> +unsigned int vc_cursor_start(unsigned int cell_height, unsigned int cursor_size)
> +{
> +	switch (vc_cursor_size(cursor_size)) {
> +	case CUR_NONE:
> +		return cell_height;
> +	case CUR_UNDERLINE:
> +	default:
> +		if (cell_height < 10)
> +			return cell_height - 1;
> +		else
> +			return cell_height - 3;
> +	case CUR_LOWER_THIRD:
> +		return cell_height - cell_height / 3;
> +	case CUR_LOWER_HALF:
> +		return cell_height - cell_height / 2;
> +	case CUR_TWO_THIRDS:
> +		return cell_height - (cell_height * 2) / 3;
> +	case CUR_BLOCK:
> +		return 0;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(vc_cursor_start);
> +
> +/**
> + * vc_cursor_end - Calculates the first scanline after the cursor within a character cell
> + * @cell_height: The overall height of the character cell
> + * @cursor_size: The size constant of cursor pattern
> + *
> + * The parameter @cell_height is the height of the character cell as
> + * displayed by the console. The argument given in @cursor_size is one
> + * of the CUR_ constants, as stored in struct @vc_data.vc_cursor_type.
> + * For unknown values, the helper draws the default cursor or an underline
> + * dash.
> + *
> + * Returns:
> + * The index of the first scanline after the cursor within the character cell
> + */
> +unsigned int vc_cursor_end(unsigned int cell_height, unsigned int cursor_size)
> +{
> +	switch (vc_cursor_size(cursor_size)) {
> +	case CUR_UNDERLINE:
> +	default:
> +		if (cell_height < 10)
> +			return cell_height;
> +		else
> +			return cell_height - 1;
> +	case CUR_NONE:
> +	case CUR_LOWER_THIRD:
> +	case CUR_LOWER_HALF:
> +	case CUR_TWO_THIRDS:
> +	case CUR_BLOCK:
> +		return cell_height;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(vc_cursor_end);
> +
>  /*
>   * /sys/class/tty/tty0/
>   *
> diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
> index fe915afdece5..1d37c7898ea0 100644
> --- a/include/linux/console_struct.h
> +++ b/include/linux/console_struct.h
> @@ -204,6 +204,10 @@ struct vc {
>  extern struct vc vc_cons [MAX_NR_CONSOLES];
>  extern void vc_SAK(struct work_struct *work);
>  
> +/*
> + * Cursors
> + */
> +
>  #define CUR_MAKE(size, change, set)	((size) | ((change) << 8) |	\
>  		((set) << 16))
>  #define CUR_SIZE(c)		 ((c) & 0x00000f)
> @@ -222,6 +226,9 @@ extern void vc_SAK(struct work_struct *work);
>  #define CUR_CHANGE(c)		 ((c) & 0x00ff00)
>  #define CUR_SET(c)		(((c) & 0xff0000) >> 8)
>  
> +unsigned int vc_cursor_start(unsigned int cell_height, unsigned int cursor_size);
> +unsigned int vc_cursor_end(unsigned int cell_height, unsigned int cursor_size);
> +
>  bool con_is_visible(const struct vc_data *vc);
>  
>  #endif /* _LINUX_CONSOLE_STRUCT_H */

-- 
Jani Nikula, Intel

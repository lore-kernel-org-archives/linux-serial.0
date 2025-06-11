Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A902E6108;
	Wed, 11 Jun 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641168; cv=none; b=rBdFBsUf/3HcGIlB15KwSFTWPqgdhLj8JL4nULRzYYsawNM+pyKLiM5YYLy5815ogID/dmbIb6bzoJUr6qWthiXLjQzYkJfpGUXasVNVKdnjWBgN+izjComHBB+VGsreZ2FZxAv8pRIs+9d9EaYdB0gAXgl+dIiCv2LD1rH8800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641168; c=relaxed/simple;
	bh=2GfVP3Z9YcDigzZONt06cS6x+4ldhMcMNo3koUPT450=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jrELEcMcZE8uK+qo3vlzvQbOvoUwQQ1fkhJCDlsvGs3iBD4zlF5+/7QQRVzVLE7uVlcFOOjUfjo5xsGz7DI0JtOSYfo5GlI8SwxImyTxYyCNVXHdOxTLUdb7+HQRSwGBd7be4GCi0O5QA0Q41uHTZzouhJfOddK+keRJ0LGtwGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTnPQHIR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTnPQHIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749641167; x=1781177167;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2GfVP3Z9YcDigzZONt06cS6x+4ldhMcMNo3koUPT450=;
  b=CTnPQHIR8YJ2MNRJHuAHzOGk3AksCB2aj/r361V6PY4nVuyXVh5dTsP7
   mrMLPsYG1YB/UjhDVOo/Kf1pZ0u3WUWvHIavbI8B5n/frbmbm2dJPrEi+
   jKqNdKHT+VGkAc77pFfKOsDmeXSQ7xHgJ6FDJSicqXlVpjexdYatyjd21
   GuwwR+XssPjRy5z321jT0WJFrf7MSZ3C/mfjnpZAGwQ7jmSb2r6saj1dl
   gQy56/BuigU97tDP9+EpoOmyBn48Fc/PCBy605WJ5j+JbYihpZg+ruAMr
   EACOx2StGNOIqp7fSoa1QLMGwwbgsFKunloLYv0++SRtcKr15IX/2EoLM
   A==;
X-CSE-ConnectionGUID: 95yIAYKFQR6COTWX1XyqcA==
X-CSE-MsgGUID: kGqALrGAQEGIG07RgawYaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51772672"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="51772672"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:26:07 -0700
X-CSE-ConnectionGUID: WDQ9oEjJQESrmQ9f+xgpmg==
X-CSE-MsgGUID: SgwegByST9mmtk0IF6lBKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="151950817"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 04:26:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 14:25:59 +0300 (EEST)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/33] powerpc/powermac: remove unneeded tty includes
In-Reply-To: <20250611100319.186924-6-jirislaby@kernel.org>
Message-ID: <3bd8996c-b463-4b1d-cc45-2a84d47f6cd0@linux.intel.com>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-6-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-291572204-1749641159=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-291572204-1749641159=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> All these includes must have been cut & pasted. The code does not use
> any tty or vt functionality at all.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/platforms/powermac/setup.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platf=
orms/powermac/setup.c
> index e119ced05d10..eb092f293113 100644
> --- a/arch/powerpc/platforms/powermac/setup.c
> +++ b/arch/powerpc/platforms/powermac/setup.c
> @@ -28,13 +28,11 @@
>  #include <linux/ptrace.h>
>  #include <linux/export.h>
>  #include <linux/user.h>
> -#include <linux/tty.h>
>  #include <linux/string.h>
>  #include <linux/delay.h>
>  #include <linux/ioport.h>
>  #include <linux/major.h>
>  #include <linux/initrd.h>
> -#include <linux/vt_kern.h>
>  #include <linux/console.h>
>  #include <linux/pci.h>
>  #include <linux/adb.h>

Seems true. I had to actually scan through the file as it does have some=20
console related setup.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-291572204-1749641159=:957--

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928792F2915;
	Mon, 24 Nov 2025 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764022429; cv=none; b=uANfdKrTar5vH8wWs2M/DkcUDjZXdhW0Doyd+G44s082v9hzMMCYzO6GJBjcpi5xOu0RACjAC90NaJZ4dNsF9kt2ESvVdHxq/vmFXkaL3vWqMP9AXl7ODfPdErrETp+5b1KEOy3u8uU71FxnhlQkfW65smhYbed64gEulSdtGT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764022429; c=relaxed/simple;
	bh=GlcTQKIA4IKU/Qd7Z1l+tzgId/p55bDR4o+xEBrnMKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz/IC60YOAMx4qrnC30Zwo8GFO4urJIdB+qJ/eab4QIa6r01rA2YznzQIt9QpUGnsWrno3nmWJ243tL4iRcYPXAaNhr0iZD/aTPHRt296Z2Hpu9SQryfmmlnbK1910ZObQveWtEOfU3aaXsSwngs8QgJIack3lGe3aauQuMU4VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDdVbqYz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDdVbqYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A593EC4CEF1;
	Mon, 24 Nov 2025 22:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764022428;
	bh=GlcTQKIA4IKU/Qd7Z1l+tzgId/p55bDR4o+xEBrnMKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDdVbqYzR8DzzDXGpA3UahGGE6mHOaSPb/y32/lJGoQFMIqovTAvtbHPW705rDOrg
	 Qxcuc4p9U4ZlWWMhm8SaqQ779Mq/mepHf4qHUAFtGhV7jbhtz/xVRn7hDLXg2ulDr6
	 iGpp4qT8fr/VNIQqk4JuXXhOGM2gFDNJIYC4hNzUAKE55ikDhx9mWiXEMtueQZl2tE
	 JPItYrU6MhuvtBI3mLgT/EV/SPbLvr8azoCLrrZEmpV+jrHOSnU920rdKZ5sq2mEfM
	 SIVSPCB9MUPesSS9n+79vTVro2/KPZ9R1fItB4yeT34IkUQwjRpnpgSZ/kCJhI5jZi
	 48dbefTsI0b/Q==
Date: Mon, 24 Nov 2025 15:13:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [tty:tty-next 27/37] drivers/tty/vt/keyboard.c:1712:7: error:
 cannot jump from this asm goto statement to one of its possible targets
Message-ID: <20251124221343.GA2953435@ax162>
References: <202511241835.EA8lShgH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511241835.EA8lShgH-lkp@intel.com>

On Mon, Nov 24, 2025 at 06:25:26PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> head:   da218406dd50e0ac96bb383de4edd208286efe70
> commit: bfb24564b5fd8625ce5c007f274cabdc3b570969 [27/37] tty: vt/keyboard: use __free()
> config: powerpc-randconfig-002-20251124 (https://download.01.org/0day-ci/archive/20251124/202511241835.EA8lShgH-lkp@intel.com/config)
> compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251124/202511241835.EA8lShgH-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511241835.EA8lShgH-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/tty/vt/keyboard.c:1712:7: error: cannot jump from this asm goto statement to one of its possible targets
>                    if (put_user(asize, &a->kb_cnt))
>                        ^
>    arch/powerpc/include/asm/uaccess.h:67:5: note: expanded from macro 'put_user'
>                      __put_user(x, _pu_addr) : -EFAULT;                    \
>                      ^
>    arch/powerpc/include/asm/uaccess.h:49:3: note: expanded from macro '__put_user'
>                    __put_user_size_goto(__pu_val, __pu_addr, __pu_size, __pu_failed);      \
>                    ^
>    arch/powerpc/include/asm/uaccess.h:127:10: note: expanded from macro '__put_user_size_goto'
>            case 1: __put_user_asm_goto(x, __pus_addr, label, "stb"); break;        \
>                    ^
>    arch/powerpc/include/asm/uaccess.h:87:2: note: expanded from macro '__put_user_asm_goto'
>            asm goto(                                       \
>            ^
>    drivers/tty/vt/keyboard.c:1736:7: note: possible target of asm goto statement
>                    if (put_user(asize, &a->kb_cnt))
>                        ^
>    arch/powerpc/include/asm/uaccess.h:67:5: note: expanded from macro 'put_user'
>                      __put_user(x, _pu_addr) : -EFAULT;                    \
>                      ^
>    arch/powerpc/include/asm/uaccess.h:53:9: note: expanded from macro '__put_user'
>                                                                    \
>                                                                    ^
>    drivers/tty/vt/keyboard.c:1692:33: note: jump exits scope of variable with __attribute__((cleanup))
>                    struct kbdiacr __free(kfree) *dia = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacr),
>                                                  ^
>    drivers/tty/vt/keyboard.c:1722:23: note: jump bypasses initialization of variable with __attribute__((cleanup))
>                    void __free(kfree) *buf = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacruc),
>                                        ^

Previously reported:

  https://lore.kernel.org/202509091702.Oc7eCRDw-lkp@intel.com/

My suggested workaround in that thread is still applicable if it would
be acceptable as a formal patch:

  https://lore.kernel.org/20250909215342.GA2456480@ax162/

Cheers,
Nathan

Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA98837
	for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991255; cv=none; b=qoGrUIxFX2ptt/xtblDeibUJN8CicZ6S0khjztJypFhnVDuQG7zGEUaPTpPB7coWyu0mEZihWnPRL4qDdsgxJGXJeSK51bLiwUf3RcpFeYlH0j6rRSw+X+O5GlqxLF5TgUZ9J/FIfg2TEwq6eS2rKHct4R3Ch95PjkP0hGgbn1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991255; c=relaxed/simple;
	bh=sYo6ltkk6zgRSEpMEfHjBoWt/iK58Cj6LZPnhic6GsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO4wH8MVHOnBBKvz96hyAfYeyC3TOh5fwSOWYNwEtTA7iqgtloXPXykL5IL0Bp4ysjF1lvQw3v8/2VKFbh1alr6gSSoMIFi23HGhBRyV6Rvln2XHDxTGENwayDggli3qIhjROsM46u8Z+dbi6wsbDSmN3TP3iybGPITV6mVYgEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LD/nDxC4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LD/nDxC4"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso833459266b.0
        for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 07:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737991251; x=1738596051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=frPY3SCMiDR9FN3Xz3XT+sHgYQpviSNIqGpvVRprrgw=;
        b=LD/nDxC4z1oioAiIablMlLHQvP+J4ew+q21bU7USGRy9wiuohrCvSHPBWBEviib//k
         rLLaDMMNr19KLicsPQw0vEq1B+Ju2LpU5/3BSZv4pSSNyASSD4cqsBAzBFKBL5H0kuTa
         6HgwVhztz2Iq7ImJ2HwOZYyUP2VM64DZOa9YxhPPBXlfnZyVZ5vO4ZRxOoNT4b35MoJk
         Fsav9sWt3g6TMsiI8yIQaY/Z5Pcg/bUrE0TRTP/M2zj9DhFoMwjnGY9i5NNOa3zOEAXR
         OypVi+TfAcvDmLc9nxqs/xTfFVErhVdfd152dWuNqLpzUNdqzGnjG/YpiOk/Yk1Alj6N
         8Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737991251; x=1738596051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frPY3SCMiDR9FN3Xz3XT+sHgYQpviSNIqGpvVRprrgw=;
        b=UYbMTvl+PRtkUbQQqnee//m49fVJmCetN7hpeHLBg1OGqngzUPHKRMlQkxhS8Bp+As
         wGWkI2Y5LMlwm6Q74aCcjCfGtTkrdTl17iqglwfMtvszATIyPLC8LRWQSq20tG4KbUoG
         KZ43J5+RYO4gu1aSRpdCnz80U8/OkTCr7371X4ni2sgNN53vL7SdEfiG0DrU8oVjzMnG
         iuDsvJUFZk22pjb+Wk0cpKK/dLjn98vdkmc7eD4lf51hEHW2RZeOmCd4Q6vWqqOwx6bk
         POiyyiJkTsCB9/F78XpWqnXip2ur+SD0LM/xcgbtleLdfLON/MSOvb86GNsxaW6FV3pk
         wHWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaftJ+CARgyIEJY/sXCfSETIO2VBdmAFheTJauA/9fJP2ztU7o8LX9tlkOiW7W8fPlPIN99xt63UbyrQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyki7FgFLvPRcNuVJbQqngYvqUySaik7sYlrFoAGmDkuz3sNP23
	7vCAN6kfhfdzP/nPoFR+eecuzGBF6tuTh1jWyLLwIk2tjIdjc5DOEp6mNsch+cw=
X-Gm-Gg: ASbGncuWuFat3vuRYRGVcRpWP35+zYlTXzILDnCfRoQBcZb1WCbfmM/t3o+Wbmfx2Ka
	gntQf/t67+5BS+dTVuHzypvyszZVabEK2GsHQCVF6j5lTJQMO3aGB9Ju6Lu9BkVdt41WtwKJ618
	cAR+ogVAACv5D3mAZaCqIRveGw/0QdTHkQGXihL/5cLiMAfVsxVB5Jm8bZVr/BL7jP70CsjYGYN
	ySZ9Rjt6jArDByp8ZIG4d9ZW1vqbs6IFxu0u34pjWR6rQPdNGc4Uiwg2iY0ejASaeJCK/04Wy2E
	27xKbTg=
X-Google-Smtp-Source: AGHT+IHLBuXzB1uda5ek6sjKvmD0pZQuPIpePwAd8C/mu+x6AQ+wjmIsBR+84wh+V77kZZ6xfEWbiQ==
X-Received: by 2002:a17:907:60c9:b0:ab6:8fda:3bcf with SMTP id a640c23a62f3a-ab68fda3d9fmr669038866b.56.1737991251124;
        Mon, 27 Jan 2025 07:20:51 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760b76b7sm592771866b.87.2025.01.27.07.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 07:20:50 -0800 (PST)
Date: Mon, 27 Jan 2025 16:20:49 +0100
From: Petr Mladek <pmladek@suse.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
Message-ID: <Z5ekUTZayBD-u1O_@pathway.suse.cz>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-6-john.ogness@linutronix.de>
 <80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com>
 <84ldvcyq41.fsf@jogness.linutronix.de>
 <96b02b20-a51e-480f-a0ce-3a1457650ca9@nvidia.com>
 <84y0zbyrf0.fsf@jogness.linutronix.de>
 <bee7de35-e767-4c69-94ad-d09c92a3577a@nvidia.com>
 <sx4nrwuzs3vafnbrkgag4dkapll3itvece4k3ylvobvid2vlpk@oncxz3eq33zk>
 <lrpcbufgu7jnvepqkd3sz2qap2th45ndzv4c4vxh7v4zyhep6k@t635s7vbhkgz>
 <3e93c665-7603-4b64-a64c-a29079d8d11f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e93c665-7603-4b64-a64c-a29079d8d11f@nvidia.com>

On Mon 2025-01-27 14:54:25, Jon Hunter wrote:
> Hi John,
> 
> On 20/01/2025 16:34, Thierry Reding wrote:
> > On Mon, Jan 20, 2025 at 05:23:26PM +0100, Thierry Reding wrote:
> > > On Thu, Jan 16, 2025 at 10:41:08AM +0000, Jon Hunter wrote:
> > > > 
> > > > On 16/01/2025 10:38, John Ogness wrote:
> > > > > On 2025-01-16, Jon Hunter <jonathanh@nvidia.com> wrote:
> > > > > > > Do you at least know if it is failing to suspend or failing to resume
> > > > > > > (based on power consumption)?
> > > > > > 
> > > > > > 
> > > > > > Unfortunately, I don't. These are farm boards and so nothing local I can
> > > > > > get my hands on. For some reason all the serial console logs are not
> > > > > > available and so I am going to talk to the farm team about fixing that
> > > > > > because we should at least have serial logs.
> > > > > 
> > > > > Can you confirm that the board is actually booting? The suspend code for
> > > > > 8250_tegra.c is quite simple. I am wondering if the farm tests are
> > > > > failing somewhere else, such as the atomic printing during early boot.
> > > > 
> > > > 
> > > > Yes they are all booting fine. I have an independent boot test and that is
> > > > passing. It is just the suspend test that is failing.
> > > 
> > > I was able to capture logs, but unfortunately they don't provide much
> > > insight either. On the first try it doesn't suspend and goes back to
> > > userspace after a second or so:
> > > 
> > > --- >8 ---
> > > -sh-5.1# rtcwake --device /dev/rtc1 --mode mem --seconds 5
> > > rtcwake: assuming RTC uses UTC ...
> > > rtcwake: wakeup from "mem" using /dev/rtc1 at Thu Jan  1 00:01:00 1970
> > > [   36.332486] PM: suspend entry (deep)
> > > [   36.332832] Filesystems sync: 0.000 seconds
> > > [   36.369331] +1.8V_RUN_CAM: disabling
> > > [   36.373884] +2.8V_RUN_CAM: disabling
> > > [   36.375571] +1.2V_RUN_CAM_FRONT: disabling
> > > [   36.380359] +1.05V_RUN_CAM_REAR: disabling
> > > [   36.387399] +3.3V_RUN_TOUCH: disabling
> > > [   36.390808] +2.8V_RUN_CAM_AF: disabling
> > > [   36.393621] +1.8V_RUN_VPP_FUSE: disabling
> > > [   36.408218] Freezing user space processes
> > > [   36.413660] Freezing user space processes completed (elapsed 0.005 seconds)
> > > [   36.413680] OOM killer disabled.
> > > [   36.413693] Freezing remaining freezable tasks
> > > [   36.415033] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> > > [   36.428474] drm drm: [drm:drm_client_dev_suspend] fbdev: ret=0
> > > [   36.428527] drm drm: [drm:drm_atomic_state_init] Allocated atomic state 2e5cd010
> > > [   36.428547] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:47:crtc-0] 6a6be0ef state to 2e5cd010
> > > [   36.428561] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:63:crtc-1] 00d818c2 state to 2e5cd010
> > > [   36.428574] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:32:plane-0] 4e145b7d state to 2e5cd010
> > > [   36.428587] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:36:plane-1] dbf67d12 state to 2e5cd010
> > > [   36.428597] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:40:plane-2] 763d8809 state to 2e5cd010
> > > [   36.428608] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:44:plane-3] b6eabcf1 state to 2e5cd010
> > > [   36.428617] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:48:plane-4] 7863878c state to 2e5cd010
> > > [   36.428628] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:52:plane-5] 54b8029c state to 2e5cd010
> > > [   36.428638] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:56:plane-6] 364063af state to 2e5cd010
> > > [   36.428648] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:60:plane-7] e1c11dfb state to 2e5cd010
> > > [   36.428662] drm drm: [drm:drm_atomic_get_connector_state] Added [CONNECTOR:65:HDMI-A-1] 5cb32770 state to 2e5cd010
> > > [   36.428674] drm drm: [drm:drm_atomic_state_init] Allocated atomic state 832943c7
> > > [   36.428682] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:47:crtc-0] f09cf73d state to 832943c7
> > > [   36.428691] drm drm: [drm:drm_atomic_add_affected_planes] Adding all current planes for [CRTC:47:crtc-0] to 832943c7
> > > [   36.428700] drm drm: [drm:drm_atomic_add_affected_connectors] Adding all current connectors for [CRTC:47:crtc-0] to 832943c7
> > > [   36.428711] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:63:crtc-1] 2700922c state to 832943c7
> > > [   36.428720] drm drm: [drm:drm_atomic_add_affected_planes] Adding all current planes for [CRTC:63:crtc-1] to 832943c7
> > > [   36.428727] drm drm: [drm:drm_atomic_add_affected_connectors] Adding all current connectors for [CRTC:63:crtc-1] to 832943c7
> > > [   36.428737] drm drm: [drm:drm_atomic_check_only] checking 832943c7
> > > [   36.428759] drm drm: [drm:drm_atomic_commit] committing 832943c7
> > > [   36.428881] drm drm: [drm:drm_atomic_state_default_clear] Clearing atomic state 832943c7
> > > [   36.428897] drm drm: [drm:__drm_atomic_state_free] Freeing atomic state 832943c7
> > > [   36.429085] r8169 0000:01:00.0 eth0: Link is Down
> > > [   36.713236] Disabling non-boot CPUs ...
> > > -sh-5.1#
> > > --- >8 ---
> > > 
> > > A second attempt soft-hangs:
> > > 
> > > --- >8 ---
> > > -sh-5.1# rtcwake --device /dev/rtc1 --mode mem --seconds 5
> > > rtcwake: assuming RTC uses UTC ...
> > > rtcwake: wakeup from "mem" using /dev/rtc1 at Thu Jan  1 00:01:10 1970
> > > --- >8 ---
> > > 
> > > Where "soft-hang" means it doesn't do anything after this and I can't
> > > SIGINT out of it or anything. However, the serial seems to still be
> > > responsive.
> > 
> > To clarify, this was on top of next-20250120 and reverting the patches
> > that Jon mentioned suspend/resume is fixed for me as well.
> > 
> > I do have a local device that I can test on, so if there's any patches
> > you want me to try, or any options to enable to get more information,
> > please let me know.
> 
> 
> Any feedback on this? Our boards are still broken with this change.

AFAIK, this patch has been reverted in linux-next last week, see
https://lore.kernel.org/r/84wmenqm03.fsf@jogness.linutronix.de

John had a training. I believe that he would look at these
suspend-related problems before sending another revision
of the patchset.

Best Regards,
Petr

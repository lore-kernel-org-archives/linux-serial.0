Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72C18026;
	Tue, 14 May 2024 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715661162; cv=none; b=cYjvh7ZKUwmackQlAklA8zs1jmPzFuj0+6tCo+3yJiQiVL6fAN+UBgH7JVYzZ8VoBQgJoWDwEqWClTY8mtf64TflUlVxfLKlPCzmqdaAvEv8c2NHSNALrCYbYGkzQIZGlginNx+qTroYnzU51GWv7eQno6xnicyyzIxx6wos3fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715661162; c=relaxed/simple;
	bh=Y3ORLDWMvf238L0QLHUG319akzxeS7ywqW/nxFGRVj8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=b+LDTZ4a3fKRq764XKsf/k0DWaAIM9wBjJ2iKKGIa4UqnHK2vy84ykt9p7ic3DTCMNlyDyYZuRz7rDVzPYuBp8xM2xxwZWCgKjSamFZuM4WBnjX0n6tO3OMSAlEiB/HP6Mawxa0pyJ1WcdBjJhozi1uZFMX0QSyvvGN07vKLkl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg3t0mV/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg3t0mV/"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a0906a7aso153634066b.1;
        Mon, 13 May 2024 21:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715661159; x=1716265959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgTPDIdjSRWLN5VOr/94gFsl27B1qYJKvP5tv5bWr9g=;
        b=Qg3t0mV/m4rinEl285AKGu4LerhgxboWlwwvZ/kclFTeTqOPlrBG5u1kUJ4Al2ndBb
         9+Iqb0Mn1sXOieJ0ehWhba1y2vceORqXW+nVFFszyoMeXD06QW793Md75mMTnfFv/FCq
         zKPR/A0Thz1dZA1SOzuZwbnQpCf2k4ZUxskNXgXSSxNMsgRK/ATTnMdZtz0xCV1pa0N7
         YHvfViL0LmQHEmMiiQKDDpcqi5azPsMJeXELFeI+zjAtqWd6H3p3Ue6SI55xG4LnSW3g
         jTSJvCB0/554SU7jKEb3tO532bUoD/44+ktjQDdZguefXPbkVvZ0BvQeXcvsdKvcIaJV
         iI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715661159; x=1716265959;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jgTPDIdjSRWLN5VOr/94gFsl27B1qYJKvP5tv5bWr9g=;
        b=dpsCiFeKZX3s7MBvoPdmYajomKRPQJw8FaAgiLFP5xwwHciht+mP/X2ZvCbl5U7/XY
         pwwqGpL28WjuPK221Mra0VYqJhs6TFOD27ATanlGQFqCUQ47ZdoFmaPu21F88e5rPmyu
         3vvgQQIhuE5m8SSXl4laG7FK6+V8y19Rxd7qDzBebFazcK30G2IjUR9IhYGsxjDX8ofc
         a9G7lDmix29kSaLqtOkiTPzShkpaBzFxLGbjhFHezLfQ73zR9ysm8+5W0Y6YzcVyC2xm
         hLTMFPKiZH1CMWED3D6l/dZdIYNOSlSbxIz47PPrKLSEdt51J7sCnNCka/NGdarXgx+X
         8qpA==
X-Forwarded-Encrypted: i=1; AJvYcCX02xGeIGopyyrKauLCHsqDMyab8HiB6m5QO4dSMmt272oDMjgRl/9j8ToKaG05n0fYq2DGx7+tKSh+oKvBQLUSlT4rj2vwy4CzoTUYHeVkt5VuXmGYsKF41uAH3FGxj7wGB3ptBh+BQlhb
X-Gm-Message-State: AOJu0YzOV0yNQKvqs0OQmjliCZVVaZ86y0Y2RbEl6uozWcs1Z1aMl8EO
	mPmutnuRAYHSB4TgPW16JzFaInjq/2FeDnPP4SD3TYKdlNbF89JW
X-Google-Smtp-Source: AGHT+IEUoj6f8wyS1jdQZliRA9Ol4cmk941rUs8WpauT7UcvfV4kTC8SuaLV0U4NeE3yMpcDb7bkeA==
X-Received: by 2002:a17:906:f591:b0:a5a:5bf2:b889 with SMTP id a640c23a62f3a-a5a5bf2b8b4mr633408366b.0.1715661159336;
        Mon, 13 May 2024 21:32:39 -0700 (PDT)
Received: from [192.168.0.101] (p57935690.dip0.t-ipconnect.de. [87.147.86.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01724sm674438566b.162.2024.05.13.21.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 21:32:38 -0700 (PDT)
Message-ID: <8fe72cec-adba-42dd-9185-15e777714a81@gmail.com>
Date: Tue, 14 May 2024 06:32:37 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [Bug] staging: rtl8723bs: Bluetooth stops working after patch:
 serial: 8250_dw: Do not reclock if already at correct rate
To: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc: Peter Collingbourne <pcc@google.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have a ODYS Trendbook next 14 with the wlan/bluetooth module rtl8723bs.

Bluetooth stops working with the following commit:
commit e5d6bd25f93d6ae158bb4cd04956cb497a85b8ef (HEAD)
Author: Peter Collingbourne <pcc@google.com>
Date:   Thu Feb 22 11:26:34 2024 -0800
     serial: 8250_dw: Do not reclock if already at correct rate

Please find dmesg below. Module has issues to load firmware.

To enshure that this is the function breaking commit I applied the 
commit reversed on top of the latest kernel from the staging tree. Then 
bluetooth is working again.

I can support with further tests. I do not have a good proposal for a 
fix as I expect a lot of side effects. Please send me proposals for a 
fix. Comming Thursday I will be OOO.

Thanks for your support.

Bye Philipp


dmesg when not working:
[   26.904914] Bluetooth: Core ver 2.22
[   26.905130] NET: Registered PF_BLUETOOTH protocol family
[   26.905136] Bluetooth: HCI device and connection manager initialized
[   26.905154] Bluetooth: HCI socket layer initialized
[   26.905161] Bluetooth: L2CAP socket layer initialized
[   26.905184] Bluetooth: SCO socket layer initialized
[   27.291346] audit: type=1130 audit(1715629261.116:39): pid=1 uid=0 
auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 
msg='unit=systemd-tmpfiles-setup comm="systemd" 
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   27.335410] audit: type=1334 audit(1715629261.160:40): prog-id=57 op=LOAD
[   29.472422] usb 1-4: Found UVC 1.00 device USB 2.0 Camera (058f:5608)
[   29.494762] usbcore: registered new interface driver uvcvideo
[   29.506692] RPC: Registered named UNIX socket transport module.
[   29.506704] RPC: Registered udp transport module.
[   29.506707] RPC: Registered tcp transport module.
[   29.506709] RPC: Registered tcp-with-tls transport module.
[   29.506711] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   29.532484] Bluetooth: HCI UART driver ver 2.3
[   29.532503] Bluetooth: HCI UART protocol H4 registered
[   29.532507] Bluetooth: HCI UART protocol BCSP registered
[   29.532594] Bluetooth: HCI UART protocol LL registered
[   29.532599] Bluetooth: HCI UART protocol ATH3K registered
[   29.533139] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   29.533325] Bluetooth: HCI UART protocol Intel registered
[   29.533506] Bluetooth: HCI UART protocol Broadcom registered
[   29.533541] Bluetooth: HCI UART protocol QCA registered
[   29.533546] Bluetooth: HCI UART protocol AG6XX registered
[   29.533572] Bluetooth: HCI UART protocol Marvell registered
[   30.114887] cfg80211: Loading compiled-in X.509 certificates for 
regulatory database
[   30.172864] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   30.175628] Loaded X.509 cert 'wens: 
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   30.269514] Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000b 
lmp_ver=06 lmp_subver=8723
[   30.273192] Bluetooth: hci0: RTL: rom_version status=0 version=1
[   30.273218] Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
[   30.300067] Bluetooth: hci0: RTL: loading 
rtl_bt/rtl8723bs_config-OBDA8723.bin
[   30.328993] Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
[   30.617609] input: chtnau8824 Headset as 
/devices/pci0000:00/808622A8:00/cht-bsw-nau8824/sound/card1/input15
[   31.630950] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   31.630966] Bluetooth: BNEP filters: protocol multicast
[   31.631013] Bluetooth: BNEP socket layer initialized
[   32.388997] Bluetooth: hci0: command 0xfc20 tx timeout
[   33.397774] NET: Registered PF_QIPCRTR protocol family
[   35.872260] r8723bs: module is from the staging directory, the 
quality is unknown, you have been warned.
[   36.008866] pnetdev = 0000000086c577c1
[   38.957652] rtl8723bs: acquire FW from file:rtlwifi/rtl8723bs_nic.bin
[   39.065930] ax88179_178a 2-1:1.0 enp0s20u1: ax88179 - Link status is: 1
[   40.516641] Bluetooth: hci0: RTL: download fw command failed (-110)
[   41.754022] ax88179_178a 2-1:1.0 enp0s20u1: ax88179 - Link status is: 1
[   62.939117] rfkill: input handler disabled
[   66.873746] intel_sst_acpi 808622A8:00: FW Version 01.0b.02.02
[   95.201213] systemd-journald[587]: 
/var/log/journal/deb6c1cc9b434036821e1d20b20e14ec/user-1000.journal: 
Journal file uses a different sequence number ID, rotating.
[   96.212917] rfkill: input handler enabled
[  104.357628] rfkill: input handler disabled
[  124.215728]  mmcblk1: p1 p2 p3
[  169.291952] netfs: FS-Cache loaded
[  169.343759] Key type dns_resolver registered
[  170.689598] Key type cifs.spnego registered
[  170.689677] Key type cifs.idmap registered
[  170.691671] CIFS: Attempting to mount //192.168.2.110/kernelcomp
[  181.038648]  mmcblk1: p1 p2 p3

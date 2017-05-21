From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: gpio-exar: Why filtering out Commtech devices?
Date: Sun, 21 May 2017 13:46:01 +0200
Message-ID: <18f4b5cb-cba0-aab4-7958-84a5b8d28935@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Sudip,

why do we carry

	if (pcidev->vendor != PCI_VENDOR_ID_EXAR)
		return -ENODEV;

in gpio_exar_probe? This effectively prevents that

	EXAR_DEVICE(COMMTECH, COMMTECH_4222PCIE, pbn_exar_XR17V35x),
	EXAR_DEVICE(COMMTECH, COMMTECH_4224PCIE, pbn_exar_XR17V35x),
	EXAR_DEVICE(COMMTECH, COMMTECH_4228PCIE, pbn_exar_XR17V35x),

gain GPIO support. Do those devices lack access to the pins? Or can we
drop the filter. I don't have access to those devices, just wondering
because the code is not explaining the reason.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

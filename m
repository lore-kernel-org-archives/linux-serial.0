From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v13 1/2] serial: exar: split out the exar code from
 8250_pci
Date: Mon, 6 Feb 2017 15:45:46 +0100
Message-ID: <82b6d515-7ac8-5593-e4e7-d694612f94c1@siemens.com>
References: <1485815302-5708-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485815302-5708-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2017-01-30 23:28, Sudip Mukherjee wrote:
> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> 
> Add the serial driver for the Exar chips. And also register the
> platform device for the GPIO provided by the Exar chips.
> 

And another question: you left pci_fastcom335_setup and related things
untouched - did that code come later, or is it left in 8250_pci.c for a
reason?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

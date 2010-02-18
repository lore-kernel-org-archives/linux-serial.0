From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/2] Implement DMA support for the sh-sci.c serial driver
Date: Thu, 18 Feb 2010 17:29:59 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1002181624190.4373@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Magnus Damm <damm@opensource.se>, Dan Williams <dan.j.williams@intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The two patches in this series add DMA support to the sh-sci SCI(F) serial 
driver. The worst problem is partial reception. Since we don't know in 
advance how many bytes we're going to receive, we submit a DMA buffer 
_and_ enable the Rx interrupt. When data arrives, we get an interrupt and 
the data is written into DMA buffers. In the ISR we then set a timeout, if 
within this time we get no DMA completion callback, we have a partial 
buffer. Unfortunately, dmaengine API currently doesn't support retrieving 
partially received DMA buffers, therefore we have to hijack the 
.device_terminate_all() call to collect the data. A better approach would 
be to add a stop-transfer / collect-partial call to the API.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

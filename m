From: "Francisco M. Marzoa Alonso" <fmmarzoa@softronica.org>
Subject: Re: Migrating from Windows to LiNUX (SOLUTION)
Date: Wed, 25 Aug 2004 08:32:53 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200408250828.39788.fmmarzoa@softronica.org>
References: <200408201025.48492.fmmarzoa@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 55.Red-213-4-20.pooles.rima-tde.net ([213.4.20.55]:36224 "EHLO
	softronica.org") by vger.kernel.org with ESMTP id S267259AbUHYGYG
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Aug 2004 02:24:06 -0400
Received: from 10.10.0.21 (unknown [10.10.0.21])
	by softronica.org (Postfix) with ESMTP id C8E637E89
	for <linux-serial@vger.kernel.org>; Wed, 25 Aug 2004 08:16:25 +0200 (CEST)
In-Reply-To: <200408201025.48492.fmmarzoa@gmx.net>
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Friday 20 August 2004 10:25, Francisco M. Marzoa Alonso wrote:
> Hi,
>
> I'm migrating from Windows to LiNUX an application that communicates with
> an RFID reader through serial port to update device's firmware, but I've
> lost more than eight hours trying to read a char from the device without
> success.

The main trouble was very stupid:

> int CommReadChar (HANDLE HND, int Wait, unsigned char* Data) {
> 	struct timeval TOut;
> 	fd_set readfs;
>
> 	FD_ZERO(&readfs);
> 	FD_SET (HND, &readfs);
>
> 	TOut.tv_sec = 0;
> 	TOut.tv_usec = Wait;
>
> 	if ( select ( 1, &readfs, NULL, NULL, &TOut ) ) {
> 		return ( read (HND, &Data, 1) );
> 	} else {
> 		perror ("CommReadChar TIMEOUT while waiting for reading");
> 		return 0;
> 	}
> }

That "read (HND, &Data, 1)" must be "read (HND, Data, 1)" because Data is yet 
declared as a pointer.




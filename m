From: "Francisco M. Marzoa Alonso" <fmmarzoa@softronica.org>
Subject: Re: Migrating from Windows to LiNUX speed problems
Date: Wed, 25 Aug 2004 10:21:12 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200408251021.12520.fmmarzoa@softronica.org>
References: <200408250848.17379.fmmarzoa@softronica.org> <200408250925.26394.fmmarzoa@softronica.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 55.Red-213-4-20.pooles.rima-tde.net ([213.4.20.55]:53377 "EHLO
	softronica.org") by vger.kernel.org with ESMTP id S268534AbUHYINN
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Aug 2004 04:13:13 -0400
Received: from 10.10.0.21 (unknown [10.10.0.21])
	by softronica.org (Postfix) with ESMTP id 3FF947D12
	for <linux-serial@vger.kernel.org>; Wed, 25 Aug 2004 10:05:04 +0200 (CEST)
In-Reply-To: <200408250925.26394.fmmarzoa@softronica.org>
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Well, that's it:

int SetPortLowLatency ( char *com_port_name ) {
        HANDLE HND;

        struct serial_struct sset;
        DWORD t_end;

        if ( (HND = open ( com_port_name, O_RDWR | O_NOCTTY | O_NONBLOCK )) < 
0 )
                return 0; // Couldn't open serial port

        if ( ioctl(HND, TIOCGSERIAL, &sset) )
                return 0; // Couldn't get current serial port settings

        sset.flags |= ASYNC_LOW_LATENCY;

        if ( ioctl(HND, TIOCSSERIAL, &sset) )
                return 0; // Couldn't set low_latency flag

        close (HND);

        t_end = GetTickCount ()+T_WAIT_LOW_LATENCY;
        while ( GetTickCount () < t_end ); // Wait a bit

        return 1;
}


Now it works fine. Thx. everybody. :-)


From: Joshua Colvin <jcolvin@marisys.net>
Subject: Re: AT commands problem
Date: Wed, 5 Nov 2003 08:12:18 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <AEC63860-0F91-11D8-B292-000A959AFBBA@marisys.net>
References: <1068036993.23598.19.camel@sizif.yugolot.co.yu>
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [12.170.16.130] ([12.170.16.130]:43014 "EHLO
	grampus.marisys.net") by vger.kernel.org with ESMTP id S262884AbTKENMU
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2003 08:12:20 -0500
In-Reply-To: <1068036993.23598.19.camel@sizif.yugolot.co.yu>
List-Id: linux-serial@vger.kernel.org
To: Marko Krstic <marko@intralot.co.yu>
Cc: linux-serial@vger.kernel.org

This uses a TCP socket to connect to the serial port. First it sends 
the init string,
then dials the number. It's not great code, it could be optimized (by 
making a procedure
out of the whiles, etc.), but it might give you some ideas. 
'send_to_port' does nothing
but write().


    fd_set          readset;             /* our set of fd to listen to */
    struct timeval  loopdelay;           /* defines how long select 
should wait */
    int             num_bytes;           /* keeps track of how many 
bytes we care about */
    int             i;                   /* counter */
    int             j;                   /* counter */
    char            *buffer;             /* temporary storage place */
    char            *stringSoFar;
    int             bufferSize = 1024;
    int             select_value;        /* value that select() returns 
*/

    buffer = (char *) malloc (sizeof(char) * (bufferSize+1));
    strcpy(buffer, "");

    stringSoFar = (char *) malloc (sizeof(char) * (bufferSize+1));
    strcpy(stringSoFar, "");

    /* if we are speaking thru a POTS modem, we must first dial the 
number */
    if (enviro->PHYSICALLY_CONNECTED == DDCT_POTS)
    {
       /* send the init string */
       send_to_port(port->fd, port->modem_init_string, 
strlen(port->modem_init_string));
       send_to_port(port->fd, "\r", 1);

       while (TRUE)
       {
          strcpy(buffer, "");
          loopdelay.tv_sec = 60;  /* could take many seconds to get a 
response */
          loopdelay.tv_usec = 0; /* must reset this for each call */
          FD_ZERO(&readset);    /* clear all bits in this set */
          FD_SET(port->fd, &readset);     /* watch our data instrument */

          /* sit here waiting for input.... */
          if ((select_value = select((port->fd)+1, &readset, NULL, NULL, 
&loopdelay)) > 0)
          {
             if ((num_bytes = read(port->fd, buffer, bufferSize)) > 0)
	    {
	       strncat(stringSoFar, buffer, num_bytes);
                /* did we get an OK? */
                if (strstr(stringSoFar, "OK") != NULL)
                {
                   /* we got a connect! */
                   break;
                } /* end if we got CONNECT */

             } /* end if num_bytes > 0 */

          } /* end select returned > 0 */

          else if (select_value == 0)
          {
             /* timed-out, never got an OK, give up */
             free (buffer);
             free (stringSoFar);
             return (FALSE);
          } /* end else if select returned 0 */
       } /* end while */

       /* if we made it here, we got an OK */
       strcpy(stringSoFar, "");

       /* now dial the number */
       send_to_port(port->fd, "ATDT", 4);
       send_to_port(port->fd, port->modem_phone_number, 
strlen(port->modem_phone_number));
       send_to_port(port->fd, "\r", 1);

       while (TRUE)
       {
          strcpy(buffer, "");
          loopdelay.tv_sec = 60;  /* could take many seconds to get a 
response */
          loopdelay.tv_usec = 0; /* must reset this for each call */
          FD_ZERO(&readset);    /* clear all bits in this set */
          FD_SET(port->fd, &readset);     /* watch our data instrument */

          /* sit here waiting for input.... */
          if ((select_value = select((port->fd)+1, &readset, NULL, NULL, 
&loopdelay)) > 0)
          {
             if ((num_bytes = read(port->fd, buffer, bufferSize)) > 0)
	    {
                strncat(stringSoFar, buffer, num_bytes);
                /* did we get a CONNECT? */
                if (strstr(stringSoFar, "CONNECT") != NULL)
                {
                   /* we got a connect! */
                   break;
                } /* end if we got CONNECT */

             } /* end if num_bytes > 0 */

          } /* end select returned > 0 */

          else if (select_value == 0)
          {
             /* timed-out, never got a CONNECT, give up */
             free (buffer);
             free (stringSoFar);
             return (FALSE);
          } /* end else if select returned 0 */
       } /* end while */

    } /* end are we using a POTS modem */


    /* if we got here and are using a POTS modem, then we know the 
modem-side of things has succeeded */



On Wednesday, November 5, 2003, at 07:56  AM, Marko Krstic wrote:

> 	Hi,
>
> 	could anyone send example of C code witch communicates with modem on
> /dev/ttyS0.
>
> 	I can send AT commands to modem, but I can't read modems response.
> HOWTOs on Internet doesn't help.
>
> 	Thanks!
>
> -- 
> Best regards,
> Marko Krstic
>
> E-mail: marko@intralot.co.yu
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

